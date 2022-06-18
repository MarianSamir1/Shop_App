import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/home/cart/cart_screen.dart';
import 'package:shop_app/modules/home/search/search_screen.dart';
import 'package:shop_app/shared/styels/constants.dart';

Widget customTextFormFeild({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required Icon prefixIcon,
  required String label,
  Icon? suffixIcon,
  Function? onTap,
  Function? suffixPressed,
  bool obscure = false,
  required String error,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: (s) {
        if (s!.isEmpty) {
          return error;
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: suffixIcon)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: label),
    );

PreferredSizeWidget appBar(
        {Color color = Colors.black,
        Color background = Colors.white,
        String title = 'Salla',
        required int count,
        required bool condition,
        required BuildContext context}) =>
    AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: background,
          statusBarIconBrightness:
              color == Colors.white ? Brightness.light : Brightness.dark),
      backgroundColor: background,
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      titleSpacing: 0,
      actions: [
        IconButton(
            onPressed: () {
              navigate(context, const SearchScreen());
            },
            icon: Icon(
              Icons.search,
              color: color,
            )),
        Center(
          child: Stack(
            children: [
              IconButton(
                onPressed: () {
                  navigate(context, const CartScreen());
                },
                icon: Icon(Icons.shopping_cart_rounded, color: color),
              ),
              condition ?
               Positioned(
                top: 0.01,
                right: 4,
                child: CircleAvatar(
                  child: Text(
                    '$count',
                    style: const TextStyle(color: Colors.white),
                  ),
                  minRadius: 10.50,
                  backgroundColor: Colors.red,
                ),
              ): Container(),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        )
      ],
      leading: IconButton(
          onPressed: () {
               ZoomDrawer.of(context)!.toggle();
          },
          icon: Icon(Icons.menu, color: color)),
    );

Widget iconBlusAndRemove(Widget icon , Function fun) => Container(
      height: 37,
      width: 37,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: defultColor,
            width: 1.6,
          )),
      child: IconButton(
        onPressed: () {
          fun();
                },
        icon: icon,
        iconSize: 19,
      ),
    );

Widget showToastWithIcon({required String msg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent[400],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check ,color: Colors.white,),
        const SizedBox(
          width: 12.0,
        ),
        Text(msg,style: const TextStyle(color: Colors.white),),
      ],
    ),
  );
}

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum
enum ToastStates { SUCCRSS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCRSS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}


Widget BlusAndMinus(context , int id) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconBlusAndRemove(const Icon(Icons.add), (){
          ShopLayoutCubit.get(context).changeQuantityItem(id );
          
        }),
        const SizedBox(
          width: 22,
        ),
        Text(
          '${ShopLayoutCubit.get(context).productsQuantity[id]}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 22,
        ),
        iconBlusAndRemove(const Icon(Icons.remove),(){
         ShopLayoutCubit.get(context).changeQuantityItem(id , increment: false);
        }),
      ],
    );

void navigateAndFinsh(context, Widget widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

void navigate(context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget backbutton(context) => Container(
      height: 40,
      width: 40,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_outlined),
        color: defultColor,
        iconSize: 21,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: defultColor.withOpacity(0.3),
            width: 1.5,
          )),
    );

Future awesomeDialog({
  required BuildContext context ,
  required Function okPress,
  required String title
})=> 
AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO_REVERSED,
                width: 280,
                buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                headerAnimationLoop: false,
                animType: AnimType.BOTTOMSLIDE,
                title: title ,
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  okPress();
                },
              ).show();

Widget rowOfPriceAndOldPrice(
        {required dynamic price, required dynamic oldPrice, required int discount}) =>
    Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('${price} LE',
              style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            width: 10,
          ),
          discount == 0
              ? Container()
              : Text('${oldPrice.toInt()} LE',
                  style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
        ]);