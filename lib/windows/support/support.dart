import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
        padding: new EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
            right: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Nos Contacts'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.grey, thickness: 0.5),
            // SizedBox(height: 10.0),
            SizedBox(height: 25.0),
            Text(
              'Service client'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 10.0),
            Text(
              'Nos Programmes',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous sommes ouverts du lundi au vendredi de 8h:00 du matin à 17h:00 du soir',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              'Et le samedi de 10h00 à 15h00',
              style: TextStyle(
                color: Colors.grey,
                // fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 15.0),
            // SizedBox(height: 5.0),
            Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 5.0),
            Text(
              'Contactez-nous directement',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Phone: +243-(0)-976-463-775',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'Email: skiiyasarl@gmail.com',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 15.0),
            //  SizedBox(height: 5.0),
            Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 5.0),
            Text(
              'Adresse Physique',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous sommes situés au n ° 16A, Avenue de la Poste ||, Quartier Ndendere, Commune d\'Ibanda',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              ),
            ),
            Text(
              'BUKAVU - SUD-KIVU \nREPUBLIQUE DEMOCRATIQUE DU CONGO',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Developed by Ntavigwa Bashombe JB',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
