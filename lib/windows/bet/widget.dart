import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/methods/connexion.dart';

Row bottomDescriptionWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(FontAwesomeIcons.squareFull, size: 16.0, color: Colors.grey),
      SizedBox(width: 3.0),
      Text('En attente', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
      SizedBox(width: 8.0),
      //
      Icon(FontAwesomeIcons.squareFull, size: 16.0, color: Colors.lightGreen),
      SizedBox(width: 3.0),
      Text('Gagné', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
      SizedBox(width: 8.0),
      //
      Icon(FontAwesomeIcons.squareFull, size: 16.0, color: Colors.redAccent),
      SizedBox(width: 3.0),
      Text('Perdu', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
      SizedBox(width: 8.0),
      //
      Icon(FontAwesomeIcons.squareFull,
          size: 16.0, color: Colors.orange.shade300),
      SizedBox(width: 3.0),
      Text('Annulé', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
    ],
  );
}

Container displayTicketLength(int _lenMatch) {
  return Container(
    // width: 15.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.grey.shade300),
        bottom: BorderSide(color: Colors.grey.shade300),
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
      ),
      borderRadius: BorderRadius.circular(8.0),
      // color: Colors.lightBlue,
    ),
    child: Text(
      _lenMatch.toString(),
      style: TextStyle(
        color: Colors.black87,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Column notLoggedInYetHeader(String header) {
  return Column(
    children: [
      Text(header.toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 10.0),
      Divider(thickness: 0.4, color: Colors.grey),
      SizedBox(height: 15.0),
      ConnexionRequired(),
    ],
  );
}

Column noNetworkWidget() {
  return Column(
    children: [
      SizedBox(height: 10.0),
      Text(
        'Pas de réseau internet',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Column recordLoading() {
  return Column(
    children: [
      SizedBox(height: 10.0),
      Text(
        'Chargement...',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10.0),
      SpinKitCircle(
        color: Colors.lightBlue,
        size: 20.0,
      ),
    ],
  );
}

Column noRecordFound(String message) {
  return Column(
    children: [
      SizedBox(height: 10.0),
      Text(
        message.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Column bottomData(_totalRate, _currency, _stake, _toatalWinning, _bonus,
    _payout, String _status, Color _colorItem, _date, _time) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Taux Total',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Text(
            _totalRate.toStringAsFixed(2),
            // '162 115.50',
            style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 13.0),
          ),
        ],
      ),
      SizedBox(height: 5.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Mon Montant',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Text(
            _currency.toString() + ' ' + Price.getWinningValues(_stake),
            style: TextStyle(color: Colors.black, fontSize: 13.0),
          ),
        ],
      ),
      SizedBox(height: 5.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gain Total',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Text(
            _currency.toString() + ' ' + Price.getWinningValues(_toatalWinning),
            style: TextStyle(color: Colors.black, fontSize: 13.0),
          ),
        ],
      ),
      SizedBox(height: 5.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gain Bonus',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Text(
            _currency.toString() + ' ' + Price.getWinningValues(_bonus),
            style: TextStyle(color: Colors.black, fontSize: 13.0),
          ),
        ],
      ),
      // SizedBox(height: 5.0),
      SizedBox(height: 5.0),
      Divider(color: Colors.grey, thickness: 0.5),
      SizedBox(height: 5.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Paiement Total'.toUpperCase(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _currency.toString() + ' ' + Price.getWinningValues(_payout),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
      SizedBox(height: 5.0),
      Divider(color: Colors.grey, thickness: 0.5),
      SizedBox(height: 5.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Résultat:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                _status.toString().compareTo('pending') == 0
                    ? 'En attente'
                    : _status.toString().compareTo('won') == 0
                        ? 'Gagné'.toUpperCase()
                        : _status.toString().compareTo('lost') == 0
                            ? 'Perdu'.toUpperCase()
                            : 'Annulé'.toUpperCase(),
                // 'Lost'.toUpperCase(),
                style: TextStyle(
                  color: _colorItem,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(width: 5.0),
              // GET THE RIGHT ICON
              Icon(
                FontAwesomeIcons.squareFull,
                size: 12.0,
                color: _colorItem,
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 5.0),
      Divider(color: Colors.grey, thickness: 0.5),
      // SizedBox(height: 5.0),
      SizedBox(height: 15.0),
      Container(
        alignment: Alignment.center,
        child: Text(
          'Pari placé le ' + _date.toString() + ' à ' + _time.toString(),
          style: TextStyle(color: Colors.grey, fontSize: 11.0),
        ),
      ),
      SizedBox(height: 10.0),
      bottomDescriptionWidget(),
      SizedBox(height: 20.0),
    ],
  );
}
