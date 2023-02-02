import 'dart:convert' as cnv;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : _Iskele(),
    );
  }
}

class _Iskele extends StatefulWidget {
  const _Iskele({Key? key}) : super(key: key);

  @override
  State<_Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<_Iskele> {
  late List productList;
  late bool loading = true;
  getAllProducts() async {
    var response = await http.get(Uri.parse("https://raw.githubusercontent.com/AkYazilimDestek/flutter_urunApiget/main/urunler.json"));
    if (response.statusCode == 200){
      setState(() {
        productList = json.decode(response.body);
        loading = false;
        print(productList);
      });
      return productList;
    }
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUUTER ListView"),
      ),
      body: Center(
        child: loading ? CircularProgressIndicator() : ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context,index){
            return ListTile(
              leading : Text(productList[index]['product_name']),
              title: Text("${productList[index]['product-price']}" + " ₺"),
              trailing: Text("${productList[index]['product_stock']}" + " KALAN STOK"),
            );
        }),
      ),
    );
  }
}
