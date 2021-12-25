import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/models/menu_model.dart';
import 'package:shop_app/modules/home/address/address_screen.dart';
import 'package:shop_app/modules/home/contact_us/contact.dart';
import 'package:shop_app/modules/home/help_screen/help_screen.dart';
import 'package:shop_app/modules/home/my_orders/my_orders.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/chash_helper.dart';
import 'package:shop_app/shared/styels/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class MenuScreen extends StatelessWidget {

  const MenuScreen({Key? key}) : super(key: key);

  static List<MenuItem> allItem = [
    MenuItem(titile: 'Home', iconData: Icons.home),
    MenuItem(titile: 'Profile', iconData: Icons.person),
    MenuItem(titile: 'My Orders', iconData: Icons.shopping_bag),
    MenuItem(titile: 'Add Your Address', iconData: Icons.location_on),
    MenuItem(titile: 'Contact Us', iconData: Icons.info_outline),
    MenuItem(titile: 'Help', iconData: Icons.help)
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          backgroundColor: defultColor,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.red[600],
            foregroundColor: Colors.white,
            elevation: 20,
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO_REVERSED,
                width: 280,
                buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                headerAnimationLoop: false,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Log Out',
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  ChashHelper.removeData(key: 'token').then((value) {
                    print('Log Outttttt');
                    navigateAndFinsh(context, const LoginScreen());
                  }).catchError((error) {
                    showToast(
                        msg: 'Some thing error try again',
                        state: ToastStates.ERROR);
                  });
                },
              ).show();
            },
            icon: const Icon(Icons.exit_to_app),
            label: const Text("Log Out"),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: SafeArea(
            child: SizedBox(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 15),
                    child: Material(
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://choicepsychology.com.au/wp-content/uploads/photo-1494790108377-be9c29b29330.jpg',
                        fit: BoxFit.cover,
                        height: 110,
                        width: 110,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 13, left: 15, bottom: 30),
                    child: Text('Marian Samir',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  ...allItem.map((e) => ListTile(
                        minLeadingWidth: 20,
                        leading: Icon(e.iconData),
                        title: Text(
                          e.titile,
                          style: const TextStyle(fontFamily: 'Amaranth'),
                        ),
                        onTap: () {
                          switch(e.titile){
                           case 'Home':
                           ShopLayoutCubit.get(context).changeBottomScreen(0);
                            ZoomDrawer.of(context)!.toggle();
                            break;
                            case 'Profile' :
                            ShopLayoutCubit.get(context).changeBottomScreen(3);
                            ZoomDrawer.of(context)!.toggle();
                            break;
                            case 'My Orders' :
                            navigate(context, const MyOrdersScreen());
                            break;
                            case 'Add Your Address' :
                            navigate(context, const AddressScreen());
                            break;
                            case 'Contact Us' :
                            navigate(context, const ContactUsScreen());
                            break;
                            case 'Help' :
                            navigate(context, const HelpScreen());
                            break;
                          }
                        },
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
