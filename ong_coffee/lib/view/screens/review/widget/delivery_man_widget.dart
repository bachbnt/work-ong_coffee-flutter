import 'package:ongcoffee/controller/splash_controller.dart';
import 'package:ongcoffee/data/model/response/order_model.dart';
import 'package:ongcoffee/util/dimensions.dart';
import 'package:ongcoffee/util/styles.dart';
import 'package:ongcoffee/view/base/custom_image.dart';
import 'package:ongcoffee/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryManWidget extends StatelessWidget {
  final DeliveryMan deliveryMan;
  DeliveryManWidget({@required this.deliveryMan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: [BoxShadow(
          color: Colors.grey[Get.isDarkMode ? 700 : 300],
          blurRadius: 5, spreadRadius: 1,
        )],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('delivery_man'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
        ListTile(
          leading: ClipOval(
            child: CustomImage(
              image: '${Get.find<SplashController>().configModel.baseUrls.deliveryManImageUrl}/${deliveryMan.image}',
              height: 40, width: 40, fit: BoxFit.cover,
            ),
          ),
          title: Text(
            '${deliveryMan.fName} ${deliveryMan.lName}',
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
          ),
          subtitle: RatingBar(rating: deliveryMan.avgRating, size: 15, ratingCount: 0),
          trailing: InkWell(
            onTap: () => launch('tel:${deliveryMan.phone}'),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).disabledColor.withOpacity(0.2)),
              child: Icon(Icons.call_outlined),
            ),
          ),
        ),
      ]),
    );
  }
}
