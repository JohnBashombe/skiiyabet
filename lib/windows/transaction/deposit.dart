import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skiiyabet/methods/connexion.dart';

double depositAmount = 0;

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        padding: new EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0),
            left: BorderSide(color: Colors.grey, width: 1.0),
            right: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: [
            Center(
              child: Text(
                'Dépôt'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
            SizedBox(height: 10.0),
            if (Selection.user == null) ConnexionRequired(),
            // SizedBox(height: 5.0),
            Text(
              'Comment déposer?'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            // Text(
            //   'Coming Soon',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 13.0,
            //   ),
            // ),
            SizedBox(height: 10.0),
            Text(
              'Avant de pouvoir placer un pari, vous devez d\'abord déposer de l\'argent sur votre compte de paris.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            Text(
              'Si vous n\'avez pas d\'argent sur votre compte SKIIYA BET, vous devez effectuer un dépôt avant de placer des paris.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Système de Payement Disponible'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 5.0),
            Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
            SizedBox(height: 10.0),
            Text(
              '1. Vodacom M-Pesa \n2. Airtel Money \n3. Orange Money',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                'Bientôt disponible'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                padding: new EdgeInsets.all(15.0),
                onPressed: () {
                  if (mounted)
                    setState(() {
                      // do deposit logic here
                      successMessage(context, 'En cours de developement!');
                    });
                },
                fillColor: Colors.lightGreen[400],
                disabledElevation: 3.0,
                child: Text(
                  'Vérifier'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
            ),
            // SizedBox(height: 10.0),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Dépôt à partir du site',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 14.0,
            //       ),
            //     ),
            //     SizedBox(height: 5.0),
            //     Text(
            //       '(conseillé)',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 12.0,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 10.0),
            // Text(
            //   'Dépôt minimum: ' +
            //       Price.getWinningValues(Price.minimumDeposit) +
            //       ' Fc | Dépôt maximum: ' +
            //       Price.getWinningValues(Price.maximumDeposit) +
            //       ' Fc',
            //   // 'Minimum Deposit: 1000 Fc | Maximum Deposit: 1 000 000 Fc',
            //   style: TextStyle(color: Colors.grey, fontSize: 14.0),
            // ),
            // SizedBox(height: 10.0),
            // Container(
            //   padding: new EdgeInsets.all(10.0),
            //   decoration: BoxDecoration(color: Colors.grey[200]),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Entrer le montant:',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.w400,
            //           fontSize: 12.0,
            //         ),
            //       ),
            //       SizedBox(height: 8.0),
            //       Container(
            //         // margin: EdgeInsets.all(10.0),
            //         padding: EdgeInsets.symmetric(horizontal: 10.0),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border(
            //             top: BorderSide(
            //                 color: Colors.lightGreen[400], width: 2.0),
            //             bottom: BorderSide(
            //                 color: Colors.lightGreen[400], width: 2.0),
            //             left: BorderSide(
            //                 color: Colors.lightGreen[400], width: 2.0),
            //             right: BorderSide(
            //                 color: Colors.lightGreen[400], width: 2.0),
            //           ),
            //         ),
            //         child: TextField(
            //           onChanged: (value) {
            //            if (mounted)
            //             setState(() {
            //               depositAmount = double.parse(value);
            //             });
            //           },
            //           cursorColor: Colors.lightGreen,
            //           maxLines: 1,
            //           keyboardType: TextInputType.number,
            //           inputFormatters: <TextInputFormatter>[
            //             FilteringTextInputFormatter.digitsOnly
            //           ],
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 15.0,
            //               fontWeight: FontWeight.w500,
            //               letterSpacing: 0.5),
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //             hintText: 'e.x. 5000 Fc',
            //             hintMaxLines: 1,
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 15.0),
            //       Container(
            //         width: double.infinity,
            //         child: RawMaterialButton(
            //           padding: new EdgeInsets.all(15.0),
            //           onPressed: () {
            //             if (mounted)
            //             setState(() {
            //               if (Selection.user == null) {
            //                 failMessage(context, 'Connectez-Vous d\'Abord');
            //               } else {
            //                 if (depositAmount < Price.minimumDeposit) {
            //                   failMessage(context,
            //                       'Min. is: ${Price.getWinningValues(Price.minimumDeposit)} Fc');
            //                 } else if (depositAmount > Price.maximumDeposit) {
            //                   failMessage(context,
            //                       'Max. is: ${Price.getWinningValues(Price.maximumDeposit)} Fc');
            //                 } else {
            //                   // do deposit logic here
            //                   successMessage(
            //                       context, 'Demande de dépôt envoyée');
            //                 }
            //               }
            //             });
            //           },
            //           fillColor: Colors.lightGreen[400],
            //           disabledElevation: 3.0,
            //           child: Text(
            //             'déposer'.toUpperCase(),
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15.0),
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 15.0),
            //       Text(
            //         'Que se passe-t-il ensuite?',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 13.0,
            //         ),
            //       ),
            //       SizedBox(height: 8.0),
            //       Text(
            //         'Votre compte sera mis à jour automatiquement.',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 14.0,
            //         ),
            //       ),
            //       SizedBox(height: 5.0),
            //       // Text(
            //       //   'A deposit transaction will be added into the receiver account too.',
            //       //   style: TextStyle(
            //       //     color: Colors.black,
            //       //     fontSize: 13.0,
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10.0),
            // SizedBox(height: 8.0),

            // skiiyaBet(),
            // airtelMoney(),
            // orangeMoney(),
            // mPesa(),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  Widget skiiyaBet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vous pouvez déposer de l\'argent sur votre compte de paris en utilisant AIRTEL MONEY ou ORANGE MONEY ou VODACOM M-PESA. \nVoir les instructions ci-dessous:',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '- Dépôt sur le site de SKIIYA BET',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '1. Connectez-vous sur skiiyabet.com',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '2. Sélectionnez "Dépôt" dans le menu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '3. Entrez un montant de dépôt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '4. Cliquez sur le bouton de "DÉPÔSER"',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '5. Vous recevrez une demande d\'approbation sur votre téléphone portable',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '6. Lors de l\'approbation, le montant sera crédité sur votre compte de paris instantanément',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget airtelMoney() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Divider(thickness: 0.5, color: Colors.grey),
        SizedBox(height: 10.0),
        Text(
          'Dépôt via AIRTEL MONEY',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '- Composez le * 501 #',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. USD ou l\'option 2. CDF',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. Envoi de l\'argent',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. Entrer Numero Surnom',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Tapez SKIIYA',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Entrez le montant que vous souhaitez déposer en CDF ou USD',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Entrez votre code PIN pour valider le dépôt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '- Lors de l\'approbation, le montant sera crédité sur votre compte de paris',
          style: TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget orangeMoney() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Divider(thickness: 0.5, color: Colors.grey),
        SizedBox(height: 10.0),
        Text(
          'Dépôt via ORANGE MONEY',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '- Composez le * 501 #',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. USD ou l\'option 2. CDF',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. Envoi de l\'argent',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. Entrer Numero Surnom',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Tapez SKIIYA',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Entrez le montant que vous souhaitez déposer en CDF ou USD',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Entrez votre code PIN pour valider le dépôt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '- Lors de l\'approbation, le montant sera crédité sur votre compte de paris',
          style: TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget mPesa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Divider(thickness: 0.5, color: Colors.grey),
        SizedBox(height: 10.0),
        Text(
          'Dépôt via VODACOM M-PESA',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '- Composez le * 501 #',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. USD ou l\'option 2. CDF',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. Envoi de l\'argent',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Sélectionnez l\'option 1. Entrer Numero Surnom',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Tapez SKIIYA',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Entrez le montant que vous souhaitez déposer en CDF ou USD',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '- Entrez votre code PIN pour valider le dépôt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '- Lors de l\'approbation, le montant sera crédité sur votre compte de paris',
          style: TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  failMessage(BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  successMessage(BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.lightGreen[400],
        duration: Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
