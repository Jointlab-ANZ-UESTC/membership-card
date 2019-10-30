/**
 * @auther list[Form:AutherName Date]:
 * FROM>>
 * 黄明源 10.25
 *
 *              <<TO HERE
 *
 * @recent change list[Form:AutherName  Changed content]:
 * FROM>>
 * 黄明源 对代码规范的注释
 *
 *              <<TO HERE
 */
import 'package:flutter/material.dart';
import 'package:anz_flutter_app_1_2/ui/app.dart';

/*
* 请在每次提交前，在自己修改的文件顶部加上自己的署名与日期
* app用来放<app>的页面基本布局
* card_list用来放<app body>，即app主页上的card显示内容
* 其他部分内容请自己创建文件存放，最好通过app.card调用，或者通过app.card调用的路由调用
* 调用他人路由，有任何问题，请咨询本人
* */

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData.light(),
  home: App(),
));
