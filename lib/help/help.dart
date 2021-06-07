import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: new EdgeInsets.only(left: 10.0, top: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 0.0, right: 5.0),
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Règles & Conditions',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Divider(color: Colors.grey.shade300, thickness: 0.5),
            SizedBox(height: 5.0),
            Text(
              'A Remarques générales',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'A1 Règles élémentaires',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'A1.1 Parties',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les parties de chaque pari sont d\'une part la société et d\'autre part le client (dans la suite des présentes, « l\'usager »).',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.2 Personnes non autorisées à parier',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les paris par ordre et provenant de bookmakers ainsi que d\'agents de paris sont interdits. Les paris sur des compétitions auxquelles participe le parieur (sont considérés comme \"participants\" les sportifs participants, propriétaires, entraîneurs ou fonctionnaires d\'un club participant) ou les paris placés au nom d\'un participant sont interdits. En outre, les paris placés par des participants ou commissionnés par des participants sur des épreuves de Ligue, Coupe et/ou sur la compétition à laquelle le club respectif participe ne sont pas autorisés. En cas de violation de ces réglementations, la société se réserve le droit de refuser le versement de tous gains et des mises déjà investies ainsi que d\'annuler tous les paris. La société ne saurait être tenue responsable de savoir si l\'usager est membre de l\'un des groupes mentionnés. Cela signifie que la société est habilitée à prendre de telles mesures à tout moment après que l\'usager a été reconnu comme membre de l\'un des groupes indiqués.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.3 Résultat inconnu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Le parieur déclare ne pas connaître le résultat de la compétition lorsqu\'il place son pari respectif.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.4 Paris ambigus',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'La société se réserve le droit de refuser un pari en partie ou dans sa totalité et de rendre nuls les paris ambigus.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.5 Responsabilité/ Traitement des données',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'La société décline toute responsabilité pour toute erreur ou omission relative à la saisie des données, à leur transmission ou à leur exploitation. SkiiyaBet se réserve le droit de corriger immédiatement ou ultérieurement les erreurs évidentes, lors de la saisie de cotes et/ou l\'exploitation de résultats de paris (par ex. la confusion de côtes, d\'épreuves ou d\'équipes etc.) ou de déclarer nuls les paris concernés.\nLa société se réserve également le droit d\'annuler ultérieurement des paris si l\'utilisateur a gagné le pari en raison d\'un problème technique et si la société peut montrer cette/ces erreur(s) au moyen d\'enregistrements techniques. La société a la charge de prouver le problème technique. La mise de jeu/pari sera remboursée sur le compte du joueur. La société se réserve le droit d\'imputer à tous utilisateurs qui tirent sciemment profit d\'erreurs techniques ou administratifs qui se sont produites dans l\'exécution ou la réception des paiements la responsabilité de tous les préjudices qui en découlent pour la société.\n\nEst uniquement considéré comme mise valable le montant confirmé et enregistré par la société.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.6 Absence de paris organisés',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les clients sont tenus d\'enregistrer leurs demandes de paris comme individuelles. Les demandes répétées et contenant les mêmes sélections par le même client ou par des clients différents doivent être considérées nulles en conséquence. Même après que le résultat officiel des sélections relatives est déjà connu, les sélections de paris peuvent également être considérées nulles si la société croit que les clients agissent de connivence ou comme syndicat ou que les paris en question ont été placés par un ou plusieurs clients au cours d\'une période de temps courte.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.7 Manipulation de jeu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Dans le cas où la société suspecte un évènement d\'être manipulé, elle se réserve le droit, à sa discrétion, de :\n    1.  Suspendre l\'offre de tout événement ou série d\'événements dans n\'importe lequel de ses marchés ; et de\n   2.  Retarder et/ou conserver le paiement lié à un événement ou à une série d\'événements qui a lieu dans n\'importe lequel de ses marchés, et ce, jusqu\'à ce que l\'intégrité de tel événement ou d\'une telle série d\'événements puisse être confirmée par la fédération sportive concernée.\nPar ailleurs, dans le cas où les associations sportives appropriées confirmeraient une manipulation active de jeu ayant eu lieu durant n\'importe quel événement ou série d\'événements, la société se réserve le droit, à sa discrétion de suspendre tout pari placé sur ces événements, qu\'il s\'agisse d\'un individu reconnu comme ayant obtenu des informations ou des connaissances privilégiées ou bien de tout autre individu soupçonné par la société d\'agir en lien avec ce genre d\'individus.\nEn cas de soupçon de fraude ou de manipulation de jeux, la société est autorisée à transmettre vos données (y compris les informations sur les paris en relation avec les suspicions) à des associations sportives, aux autorités ou une tierce personne en charge d\'élucider de tels soupçons.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A1.8 Age et conditions légales',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Lorsqu\'il place un pari ou participe à un jeu, l\'usager déclare remplir les conditions légales requises et avoir atteint l\'âge minimal (18+) requis pour la participation audit jeu selon la législation nationale respective.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 25.0),
            Text(
              'A2 Mises',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'A2.1 Limites de mises',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chaque usager détermine lui-même ses mises à l\'exception de la restriction imposée par les limites de gains en fonction du calcul des gains et des limites de mises possibles.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A2.2 Taxation des mises de paris conformément à la Loi sur les paris sportifs et les jeux de loterie',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Conformément à l\'article 17 de la Loi sur les paris sportifs et les jeux de loterie, la taxe qui s\'applique sur les paris sportifs s\'élève à 5% de la mise. Dans le cas de paris gagnants, l\'utilisateur prend en charge une partie de la taxe prélevée (réduction par quota). La réduction par quota se calcule avec le montant des gains bruts (mise x cotes x 5%). Par conséquent, les gains possibles pour les paris gagnants s\'élèvent dès le départ à un montant équivalent aux gains nets (gains bruts moins la réduction par quota), qui sera crédité sur le compte du joueur. ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A2.3 Solde du compte',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Comme condition préalable au placement effectif d\'un pari, le solde du compte destiné à couvrir les mises - dont une taxe éventuelle conformément au paragraphe A2.2 - doit être suffisant avant la clôture de l\'acceptation des paris - traité au paragraphe 2.4 ci-dessous.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A2.4 Couverture totale',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si le solde du compte ne fournit pas la couverture totale et que la différence n\'est pas déposée sur le compte dans les délais, les paris placés seront acceptés par la société uniquement dans leur ordre de réception jusqu\'à ce que le compte de pari soit complètement couvert pour chaque pari individuel.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A2.5 Couverture partielle',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si la mise d\'un pari n\'est couverte que partiellement par le solde du compte, le pari est considéré être placé avec une mise correspondant au solde restant sur le compte.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 25.0),
            Text(
              'A3 Placer un pari',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'A3.1 Confirmation',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Un pari est accepté après confirmation par la société. Un pari est confirmé lorsqu\'il apparait sur le compte des clients dans la rubrique « Mes paris ». Dans certains cas isolés, des retards peuvent se produire. En cas de litige sur la date à laquelle le pari a été placé, seule la date à laquelle la société a enregistré le pari sera déterminante. Si, pour une raison ou pour une autre, le client ne reçoit pas de message de confirmation, le pari est encore confirmé s\'il est affiché dans la rubrique « Mes paris » sur le compte du client. Dans tous les cas, la société suppose l\'acceptation par le client de son règlement lorsque celui-ci place un pari.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.2 Paris invalides / nuls',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si un pari est déclaré « invalide » ou « nul » (par ex. annulation de la compétition faisant l\'objet du pari), celui-ci sera évalué comme « gagné » avec des cotes de 1,00. Pour les paris individuels (simples), cela signifie que l\'usager recevra le remboursement d\'un montant égal à sa mise. Dans le cas d\'un pari multiple, cela signifie que les cotes totales seront ajustées en conséquence et que le pari multiple sera encore gagné si tous les autres paris qu\'il contient le sont aussi.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.3 Late bets (paris placés en retard)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si le pari - pour quelque raison que ce soit - est placé après le début de la compétition, il sera alors invalide (cette disposition ne concerne pas les paris en direct). Le pari sera évalué comme « gagné » en utilisant les cotes de 1,00. Pour les paris en direct, ceux qui sont reçus par la société après que le résultat du pari respectif a été déterminé sont invalides et seront évalués comme « gagnés » en utilisant les cotes de 1,00.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.4 Echéance',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'L\'échéance de placement des paris sera déterminée dans tous les cas par la société.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.5 Rejet de l\'acceptation',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'La société se réserve le droit de décliner l\'acceptation de tout pari sans indiquer de motifs.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.6 Paris acceptés',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Sauf les cas mentionnés dans le présent règlement, les paris placés et acceptés à temps ne sauraient être ni révoqués ni modifiés. Pour cette raison, l\'usager engage son unique responsabilité pour assurer que tous les détails de ses paris sont corrects.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.7 Informations de résultats prématurés',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si, durant la période d\'acceptation des gains, des informations sont publiées selon lesquelles le résultat du pari peut être déterminé, l\'échéance d\'acceptation des paris sera redéterminée par la société ou le pari sera annulé. Les paris annulés seront évalués comme « gagnés » à des cotes de 1,00.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A3.8 Erreurs',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'La société décline toute responsabilité en cas d‘erreurs d\'impression, de transmission et/ou d\'évaluation. La société se réserve notamment le droit de rectifier les erreurs évidentes, même après la compétition, en saisissant les cotes de paris et/ou l\'évaluation des résultats de paris (par ex. erreurs relatives aux cotes, aux équipes, à la compétition) ou de déclarer nuls les paris concernés. La société décline également toute responsabilité concernant la correction, de l\'intégralité et de l\'actualité des services d\'informations fournis, par exemple les messages de scores et de résultats envoyés par e-mail ou par SMS. La mise est uniquement le montant confirmé et enregistré par la société. Dans le cas où le marché/la compétition erroné(e) est annulé(e), tous les paris seront nuls et évalués comme « gagnés » à des cotes de 1,00.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 25.0),
            Text(
              'A4',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'A4.1 Calcul',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Dans les paris à cotes fixes, les gains seront calculés en multipliant la mise par les cotes fixes.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A4.2 Versement',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les gains seront uniquement versés jusqu\'au maximum de leur limite (voir paragraphes « A.4.3 » et « A.4.4 »). Si le joueur place un pari dont le paiement excède la limite du gain, la société ne saura être tenue pour responsable du montant excédentaire. Dans ce cas, les versements de gains seront réduits en conséquence. Ceci s\'applique également si la société n\'a pas mis en garde le parieur contre les excès possibles des limites de gains au moment du pari.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A4.3 Limites spéciales de gains',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Des limites spéciales de gains sont en vigueur dans le cadre de Paris Pre-Match concernant des sports, compétitions et types de pari spécifiques et sont déterminées comme suit : Paris combinés : en cas de limites de gains différentes de paris formant un pari combiné, la limite de gains la plus faible sera choisie pour la limite de gains totale du pari combiné.\nEn cas de gains crédités sur un compte joueur dépassant les limites telles qu\'indiquées dans ce paragraphe, l\'entreprise se réserve le droit de réclamer la somme créditée dépassant les plafonds donnés.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A4.4 Mise réduite',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si un usager dépose plusieurs paris de même valeur (y compris la combinaison de paris simples et multiples), dont les gains totaux dépassent la limite de gains selon les paragraphes "A4.3" ou "A4.4” ; la société est habilitée à réduire la mise à l\'étendue nécessaire pour répondre aux limites de gains.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'A4.5 Protection des joueurs contre les pertes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si un joueur perd 500,000 CDF ou plus au cours d\'une période de quatre semaines, la société se réserve le droit de prendre les mesures convenables pour protéger le joueur contre d\'autres pertes.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30.0),
            Text(
              'B Résultat du pari',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'B1 Règles générales de paris',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'B1.1 Règles spécifiques sportives (B2)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ces règles varient ou font exception dans le cas de certains sports et paris. Pour cette raison, le parieur doit toujours consulter les règles spécifiques sportives de chaque discipline, disponibles dans la rubrique « Règles spéciales » - puisque celles-ci sont prioritaires aux règles générales de paris.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.2 « All bets stand » (« Tous les paris sont valides »)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Sauf stipulation contraire - dans les cas d\'exceptions figurant ci-dessous, dans l\'offre de pari ou dans les règles spéciales de chaque discipline -, le principe « All bets stand » s\'applique à tous les paris. Cela signifie que si l\'athlète (ou l\'équipe, etc..) sur lequel le pari a été placé déclare forfait et ne participe pas à la compétition - quelles qu\'en soient les raisons -, le pari est perdu si la compétition faisant l\'objet du pari a lieu. Les paris seront déclarés nuls uniquement dans des cas exceptionnels, notamment dans les cas suivants :\n•  Le tournoi/la compétition est annulé.\n•  Le tournoi/la compétition est déclaré nul(le).\n• Le lieu est modifié.\n• La compétition/le tournoi est interrompu ou reporté et ne redémarre pas, au plus tard, 72 heures après la date de départ originale.\n•  Paris en face à face (H2H) : si un ou plusieurs participants se retirent avant d\'avoir démarré la compétition/le tournoi.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.3 Ordre des équipes dans le calendrier',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'En règle générale, l\'ordre des équipes se base sur le calendrier officiel de la compétition respective. Néanmoins, dans des cas exceptionnels, l\’équipe officiellement en déplacement peut être affichée comme équipe hôte. La règle \"Tous les paris sont valides\" s\'applique quoi qu\'il en soit.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.4 Paris déterminés',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tous les paris étant déterminés (c.-à-d. dont le résultat est déjà décidé) sont valides et seront tranchés en conséquence en tenant compte de l\'abandon ultérieur de la compétition/du tournoi à tout moment.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.5 Amendement (règle des 24 heures)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'La société reconnaît uniquement les résultats ayant été achevés sur le terrain ou sur la plateforme de jeu. Les résultats provenant de mesures disciplinaires prises par un tribunal sportif ou par une autre instance judiciaire ne sont pas pris en considération. En cas de violation des lois sportives, la société se réserve le droit de geler les gains et d\'en différer le versement.\nException : tous les paris se référant au résultat final de la compétition/du tournoi seront tranchés sur le résultat officiel publié par l\'autorité gouvernante de la discipline/ligue/compétition respective, généralement directement après la fin de la compétition. Si le résultat officiel est modifié dans les 24 heures suivant la fin de la compétition par l\'organisme gouvernant respectif, la société se réserve alors le droit de corriger la décision en conséquence (c.-à-d. que les gains déjà versés seront annulés après que les paris aient été tranchés en fonction du résultat modifié). Si une compétition/un tournoi n\'est pas achevé pour une raison quelconque (par ex. mauvais temps, problèmes de cohue, etc.) mais qu\'il existe un résultat officiel rendu par l\'autorité gouvernante dans les 24 heures, alors seuls les paris sur le vainqueur de la compétition/du tournoi seront tranchés en conséquence. Si aucun résultat n\'est proclamé par l\'organisme gouvernant de la discipline/ligue/compétition dans les 24 heures après la fin de la compétition, tous les paris non clôturés à la fin de l\'abandon seront nuls. Ceci est également valable pour les paris à long terme. Toutes modifications des classements effectuées au-delà de 24 heures après la fin de la compétition pour des raisons quelconques ne seront pas prises en considération quand le résultat du pari est décidé.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.6 Règle de report à 72 heures',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si une compétition faisant l\'objet d\'un pari est reportée ou annulée, ou ne débute pas à l\'horaire indiqué dans l\'offre de paris, pour quelque raison que ce soit, et est redémarrée au plus tard 72 heures après la date de départ affichée, le pari compte pour la compétition redémarrée. Si une compétition faisant l\'objet d\'un pari n\'est pas redémarrée, au plus tard, après 72 heures, les paris respectifs sont nuls.\nException : Si la date de départ d\'une compétition n\'est pas connue au moment où un pari est offert, ladite compétition sera marquée de la mention « Date à confirmer ». Pour toutes ces compétitions et ces marchés, la date de départ correcte sera entrée dès qu\'elle sera connue. Les paris sur une telle compétition seront valides même si la date de départ prévue ne correspond pas à celle réelle.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.7 Paris multiples',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'B1.7.1 Pas tous les partants',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si dans un pari multiple, le partant sur lequel le pari a été placé ne participe pas à une compétition (à l\'exception du principe « Offre sur tous les paris » (B1.2)), ou si l\'une des compétitions sélectionnée est annulée, abandonnée, supprimée, ou si elle n\'a pas lieu pour d\'autres raisons, et que les compétitions respectives faisant l\'objet du pari ne sont pas tenues dans les 72 heures, ces paris seront évalués comme « gagnés » à des cotes de 1,00, ce qui signifie que le pari multiple sera encore gagné en fonction des autres résultats en faisant partie.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.7.2 Paris relatifs',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Le client ne peut pas combiner (réemployer) les paris relatifs sur la même compétition. Les paris relatifs sont deux ou plusieurs paris différents ayant une éventualité relative.\nExemple :',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            Text(
              '•  Le pari 1 :',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ':« Quelle équipe va marquer le prochain but ? » contient les résultats suivants à parier :\no  « L\'équipe A »\no  « L\'équipe B »\no  « Aucun but »',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            Text(
              '•  Le pari 2 :',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ':« Quand le prochain but sera-t-il marqué ? » contient les résultats suivants à parier :\no  « A la période X »\no « A la période Y »\no « Aucun but »',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              '•  Puisque l\'option « Aucun but » exerce une influence sur les deux paris, ceux-ci sont considérés « relatifs » l\'un à l\'autre.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les paris relatifs ne contiennent pas nécessairement le même résultat ou ne se réfèrent pas à la même action. Puisque la relation des paris n\'est pas toujours aussi évidente que dans l\'exemple ci-dessus, la société se réserve le droit de déterminer quels paris sont relatifs l\'un à l\'autre. Si un pari multiple contenant 2 choix relatifs ou plus a été accepté par erreur, la société se réserve alors le droit de déclarer ce pari invalide (voir règle A3.2 Paris invalides / nuls).',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.8 Règles de paris ex æquo et Dead Heat (égalité)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Un ex æquo a lieu lorsque plusieurs athlètes ou nations terminent à la même place. À moins d\'une disposition contraire, les règles suivantes traitant du montant des gains entrent en vigueur si une compétition se termine ex æquo ou égalité (dead heat) et que le pari sur cette option n\'a pas été offert : les cotes des options gagnantes (se basant sur la forme décimale européenne) seront divisées par le nombre de résultats gagnants puis multipliées par la mise initiale correspondante. Ce type de calcul des profits est applicable à tous les types de cotes affichées (EU, UK, USA). Ces cas sont affichés sur votre compte dans la rubrique « Mes paris » avec la mention « d/h » (en anglais : dead heat, ex æquo).\nA moins d\'une indication contraire, cette règle vaut pour tous les cas où 2 options de pari ou plus sont évaluées comme options gagnantes.\nExemple : une épreuve de ski se termine par un ex-aequo entre l\'athlète A (cote de 4,60) et l\'athlète B (cote de 9,00). Les utilisateurs qui ont misé 10 euros sur l\'athlète A remporte 23 euros (Cote x mise / nombre de pronostics corrects = 4,6 x 10 / 2). Les utilisateurs qui ont parié 10 sur l\'athlète B remportent 45 euros (9,00 x 10 / 2).',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.9 Paris en direct',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'B1.9.1 Explication',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les paris en direct sont offerts explicitement avant et pendant une compétition sur la plateforme « Paris en direct ». Les cotes sont constamment ajustées afin de refléter le cours actuel du jeu. Afin d’éviter qu’un pari ne soit pas accepté en raison d’un changement de cotes, le client peut accepter des changements de cotes en utilisant l’option « Accepter toute modification de cotes » ou « Accepter cotes plus élevées » lors du placement d’un pari.\nDe plus amples infos sont disponibles sur le coupon de paris dans la section « Paris en direct ».',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.9.2 Résultats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pour les paris en direct, les résultats connus immédiatement après la passation d\'un marché de pari seront ceux utilisés pour évaluer le(s) résultat(s) des gains. Des modifications en conséquence (p. ex. les résultats décidés par un jury à l\'issu du jeu) n\'exercent aucune influence sur la décision du pari en direct proposé pour offre. Les paris en direct sont tranchés sur les statistiques internes de la société, qui se basent sur le cours actuel du jeu. Sauf spécification contraire, tous les paris sur les « non-partants » seront nuls dans les paris en direct.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.9.3 Règles générales',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pour les paris en direct s\'appliquent également les « Règles générales de paris » (B1) concernant l\'évaluation du jeu. Les exceptions sont des paris spéciaux, décidés avant l\'interruption réelle. Elles sont déclarées valides.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.10 Périodes de jeu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Dans toutes les disciplines avec une certaine période de jeu, le résultat à l\'issue de la période de jeu régulière (arrêts de jeu incl.) est déterminant. Aucune prolongation ou séance de tirs au but n\'exercera d\'influence sur la décision d\'un pari. Les exceptions seront annoncées lorsqu\'elles se produiront ou font partie des règles spéciales de la discipline spécifique.\nSkiiyaBet ne peut garantir en aucune façon que la période de jeu régulière d’une rencontre sportive soit respectée et corresponde aux temps de jeu ‘normaux’ de la discipline en question (comme par exemple dans le cas de matches amicaux en football). Les temps de jeu inhabituels seront communiqués si l’information est disponible et, dans tous les cas, les paris sont maintenus.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.11 Disqualifications',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pour tous les paris se référant au résultat final de la compétition/du tournoi, tout joueur/partant/équipe disqualifié(e) pour des raisons quelconques dans les 24 heures suivant la fin de la compétition / du tournoi sera considéré comme perdant.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12 Types de paris',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.1 Pari coté ou à égalité',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si le résultat est « 0 », les paris seront alors tranchés à « Egalité ».',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.2 Handicap/Progression',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'La compétition doit être achevée pour les paris à offrir.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.3 Paris globaux (tous les paris comportant les options de paris « Supérieur » et « Inférieur »)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si la compétition est abandonnée avant sa fin, tous les paris seront nuls, à moins que le total à parier le plus élevé possible ait déjà été atteint dans le cas concret de l\'offre sur tous les paris.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.4 Paris en face à face (H2H)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '•  Compétition simple : si un ou plusieurs participants se retirent avant d\'avoir démarré la compétition, alors tous les paris seront nuls. Si un participant est disqualifié ou ne termine pas la compétition pour des raisons quelconques, alors celui-ci sera considéré comme perdant. Si tous les participants du pari en face à face sont disqualifiés ou ne terminent pas la compétition, alors tous les paris sont nuls. Dans le cas de 2 participants ou plus terminant à la même position, la règle de prix « Ex æquo » (B1.7) s\'applique.\n• Tournoi : cette règle s\'applique à tous les tournois joués en système knock-out ou round robin ou appliquant un mélange des deux systèmes. Le vainqueur sera le participant le plus haut placé au classement final des tournois. S\'il n\'y a pas de classement final officiel, le dernier match/degré terminé avec succès sera considéré comme la position finale. Si deux participants ou plus terminent le tournoi à la même position ou si leur dernier match/degré terminé est le même, les règles de prix ex æquo s\'appliquent. Si un ou plusieurs participants se retirent avant d\'avoir démarré le tournoi, alors tous les paris seront nuls.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.5 Paris sur les médailles',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tous les paris sur le nombre de médailles seront évalués en fonction du tableau officiel des médailles à la fin de l\'épreuve (par ex. : Jeux olympiques, Championnats du monde...). Toutes modifications effectuées par un organisme gouvernant à une date ultérieure ne comptent pas pour les paris proposés.\nMédailles par équipes : toutes les médailles gagnées par une équipe/nation par compétition comptent comme une seule médaille peu importe le nombre de membres que comporte l\'équipe.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.6 Finalistes nominés',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les finalistes sont les joueurs/équipes qui participent bien à la finale, indépendamment de la manière dont ils/elles l\'ont atteinte (décisions des institutions compétentes incluses).',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.7 Un autre participant/ Le reste des participants',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si l’option "Un autre participant", "Le reste des participants" ou une offre similaire est proposée lors d’un pari, cette option inclut alors tous les participants, à l’exception de ceux dont le nom est cité dans ladite option – indépendamment du fait que des cotes ou non soient disponibles pour les participants en question.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Text(
              'B1.12.8 Paris spéciaux avec des cotes améliorées',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pour tous les paris qui se réfèrent aux résultats de plus d’1 épreuve, chaque épreuve doit commencer sous 72 heures à compter de l’horaire de programmation d’origine afin que tous les paris soient valides.\nSi au moins une des épreuves concernées ne commence pas à temps ou se termine sans qu’un vainqueur soit officiellement déclaré tous les paris spéciaux avec des cotes améliorées sont déclarés nuls.\nCette règle ne s’applique pas aux paris qui sont placés comme paris multiples.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15.0),
            // Divider(color: Colors.grey, thickness: 0.5),
            // SizedBox(height: 5.0),
            // Text(
            //   'Comment participer au Jackpot?',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 5.0),
            // Text(
            //   'Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat, itaque quas? Recusandae enim quas maxime rerum voluptatem quaerat ab. Cupiditate aut repellat     perspiciatis atque quae, voluptates suscipit nesciunt consequuntur accusantium!',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 14.0,
            //   ),
            // ),
            // Text(
            //   'Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat, itaque quas? Recusandae enim quas maxime rerum voluptatem quaerat ab. Cupiditate aut repellat     perspiciatis atque quae, voluptates suscipit nesciunt consequuntur accusantium!',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 14.0,
            //   ),
            // ),
            // SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
