import 'package:ongcoffeedelivery/controller/splash_controller.dart';
import 'package:ongcoffeedelivery/data/model/response/order_details_model.dart';
import 'package:ongcoffeedelivery/data/model/response/order_model.dart';
import 'package:ongcoffeedelivery/helper/price_converter.dart';
import 'package:ongcoffeedelivery/util/dimensions.dart';
import 'package:ongcoffeedelivery/util/images.dart';
import 'package:ongcoffeedelivery/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderModel order;
  final OrderDetailsModel orderDetails;
  OrderProductWidget({@required this.order, @required this.orderDetails});
  
  @override
  Widget build(BuildContext context) {
    String _addOnText = '';
    orderDetails.addOns.forEach((addOn) {
      _addOnText = _addOnText + '${(_addOnText.isEmpty) ? '' : ',  '}${addOn.name} (${addOn.quantity})';
    });

    String _variationText = '';
    if(orderDetails.variation.length > 0) {
      List<String> _variationTypes = orderDetails.variation[0].type.split('-');
      if(_variationTypes.length == orderDetails.foodDetails.choiceOptions.length) {
        int _index = 0;
        orderDetails.foodDetails.choiceOptions.forEach((choice) {
          _variationText = _variationText + '${(_index == 0) ? '' : ',  '}${choice.title} - ${_variationTypes[_index]}';
          _index = _index + 1;
        });
      }else {
        _variationText = orderDetails.foodDetails.variations[0].type;
      }
    }
    
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            height: 50, width: 50, fit: BoxFit.cover,
            image: '${Get.find<SplashController>().configModel.baseUrls.productImageUrl}/'
                '${orderDetails.foodDetails.image}',
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 50, width: 50, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(
                orderDetails.foodDetails.name,
                style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                maxLines: 2, overflow: TextOverflow.ellipsis,
              )),
              Text('${'quantity'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              Text(
                orderDetails.quantity.toString(),
                style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_SMALL),
              ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(children: [
              Text(
                PriceConverter.convertPrice(orderDetails.price - orderDetails.discountOnFood),
                style: robotoMedium,
              ),
              SizedBox(width: 5),
              orderDetails.discountOnFood > 0 ? Expanded(child: Text(
                PriceConverter.convertPrice(orderDetails.price),
                style: robotoMedium.copyWith(
                  decoration: TextDecoration.lineThrough,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: Theme.of(context).disabledColor,
                ),
              )) : SizedBox(),
            ]),

          ]),
        ),
      ]),

      _addOnText.isNotEmpty ? Padding(
        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Row(children: [
          SizedBox(width: 60),
          Text('${'addons'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
          Flexible(child: Text(
              _addOnText,
              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor,
          ))),
        ]),
      ) : SizedBox(),

      orderDetails.foodDetails.variations.length > 0 ? Padding(
        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Row(children: [
          SizedBox(width: 60),
          Text('${'variations'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
          Flexible(child: Text(
              _variationText,
              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor,
          ))),
        ]),
      ) : SizedBox(),

      Divider(height: Dimensions.PADDING_SIZE_LARGE),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
    ]);
  }
}
