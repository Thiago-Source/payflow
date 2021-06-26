import 'package:flutter/material.dart';
import 'package:payflow_nlw/modules/login/login_controller.dart';
import '../extratos_page/extratos_page.dart';
import '../../shared/widgets/boleto_list/boleto_list_controller.dart';
import '../../shared/models/user_model.dart';
import '../meus_boletos/meus_boletos_page.dart';
import 'home_controller.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _loginController = LoginController();
  final HomeController homeController = HomeController();
  final boletoListController = BoletoListController();
  double containerHeight = 152;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  homeController.setPage(0);
                });
              },
              icon: Icon(
                Icons.home,
                color: homeController.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary),
              child: IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/barcode_scanner');
                  setState(() {});
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  homeController.setPage(1);
                });
              },
              icon: Icon(
                Icons.description_outlined,
                color: homeController.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: containerHeight,
              color: AppColors.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text.rich(
                      TextSpan(
                          text: "Olá, ",
                          style: TextStyles.titleRegular,
                          children: [
                            TextSpan(
                                text: "${widget.user.name}",
                                style: TextStyles.titleBoldBackground)
                          ]),
                    ),
                    subtitle: Text(
                      "Mantenha suas contas em dia",
                      style: TextStyles.captionShape,
                    ),
                    trailing: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.photoURL!))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: InkWell(
                      onTap: () async {
                        await _loginController.googleSignOut(context);
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: AppColors.shape,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Log Out',
                            style: TextStyles.buttonBoldBackground
                                .copyWith(color: AppColors.body, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            [
              MeusBoletosPage(
                key: UniqueKey(),
              ),
              ExtratosPage(
                key: UniqueKey(),
              ),
            ][homeController.currentPage],
          ],
        ),
      ),
    );
  }
}
