import 'package:ongcoffeedelivery/controller/order_controller.dart';
import 'package:ongcoffeedelivery/controller/splash_controller.dart';
import 'package:ongcoffeedelivery/data/model/response/order_model.dart';
import 'package:ongcoffeedelivery/helper/date_converter.dart';
import 'package:ongcoffeedelivery/helper/route_helper.dart';
import 'package:ongcoffeedelivery/util/dimensions.dart';
import 'package:ongcoffeedelivery/util/images.dart';
import 'package:ongcoffeedelivery/util/styles.dart';
import 'package:ongcoffeedelivery/view/base/confirmation_dialog.dart';
import 'package:ongcoffeedelivery/view/base/custom_button.dart';
import 'package:ongcoffeedelivery/view/base/custom_snackbar.dart';
import 'package:ongcoffeedelivery/view/screens/order/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRequestWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  final bool fromDetailsPage;
  final Function onTap;
  OrderRequestWidget({@required this.orderModel, @required this.index, @required this.onTap, this.fromDetailsPage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      ),
      child: GetBuilder<OrderController>(builder: (orderController) {
        return Column(children: [

          Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder, height: 45, width: 45, fit: BoxFit.cover,
              image: '${Get.find<SplashController>().configModel.baseUrls.restaurantImageUrl}/${orderModel.restaurantLogo}',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 45, width: 45, fit: BoxFit.cover),
            )),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(
                  orderModel.restaurantName, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    orderModel.paymentMethod == 'cash_on_delivery' ? 'cod'.tr : 'digitally_paid'.tr,
                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: Theme.of(context).cardColor),
                  ),
                ),
              ]),
              Text(
                orderModel.restaurantAddress, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
              ),
            ])),
          ]),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Text(
            '${orderModel.detailsCount} ${orderModel.detailsCount > 1 ? 'items'.tr : 'item'.tr}',
            style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
          ),
          Text(
            '${DateConverter.timeDistanceInMin(orderModel.createdAt)} ${'mins_ago'.tr}',
            style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Row(children: [
            Expanded(child: TextButton(
              onPressed: () => Get.dialog(ConfirmationDialog(
                icon: Images.warning, title: 'are_you_sure_to_ignore'.tr, description: 'you_want_to_ignore_this_order'.tr, onYesPressed: () {
                  orderController.ignoreOrder(index);
                  Get.back();
                  showCustomSnackBar('order_ignored'.tr, isError: false);
                },
              ), barrierDismissible: false),
              style: TextButton.styleFrom(
                minimumSize: Size(1170, 40), padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  side: BorderSide(width: 1, color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
              child: Text('ignore'.tr, textAlign: TextAlign.center, style: robotoRegular.copyWith(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              )),
            )),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Expanded(child: CustomButton(
              height: 40,
              buttonText: 'accept'.tr,
              onPressed: () => Get.dialog(ConfirmationDialog(
                icon: Images.warning, title: 'are_you_sure_to_accept'.tr, description: 'you_want_to_accept_this_order'.tr, onYesPressed: () {
                  orderController.acceptOrder(orderModel.id, index, orderModel).then((isSuccess) {
                    if(isSuccess) {
                      onTap();
                      orderModel.orderStatus = (orderModel.orderStatus == 'pending' || orderModel.orderStatus == 'confirmed')
                          ? 'accepted' : orderModel.orderStatus;
                      Get.toNamed(
                        RouteHelper.getOrderDetailsRoute(orderModel.id),
                        arguments: OrderDetailsScreen(
                          orderModel: orderModel, isRunningOrder: true, orderIndex: orderController.currentOrderList.length-1,
                        ),
                      );
                    }else {
                      Get.find<OrderController>().getLatestOrders();
                    }
                  });
                },
              ), barrierDismissible: false),
            )),
          ]),

        ]);
      }),
    );
  }
}
