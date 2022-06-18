import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class HelpScreen extends StatefulWidget {
   const HelpScreen({ Key? key }) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

    @override
  void initState() {
    ShopLayoutCubit.get(context).getFaqs();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>( 
      listener: (context , state){} , 
      builder: (context, state) => Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Help Screen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: backbutton(context),
            ),
          ),
      body: state is FaqsLoadingState? const Center(child: CircularProgressIndicator()) : 
      ListView.separated(
        itemBuilder: (context , index)=> Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ShopLayoutCubit.get(context).helpModel!.faqsList[index].quastion , 
              style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 17),),
              Text(ShopLayoutCubit.get(context).helpModel!.faqsList[index].answer , )
            ],
          ),
        ), 
        separatorBuilder:(context , index)=> const Divider(), 
        itemCount: ShopLayoutCubit.get(context).helpModel!.faqsList.length),
    )
      );}


}