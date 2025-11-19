// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MotorTransaction {
  int logicalref;
  int? stficheref;
  int? sttransref;
  int? intransref;
  int? insltransref;
  num? inslamount;
  int? linenr;
  int? itemref;
  DateTime datE_;
  int? iocode;
  int? invenno;
  int? fichetype;
  int? sltype;
  int? slref;
  int? locref;
  num? mainamount;
  int? uomref;
  num? amount;
  num? remamount;
  num? remlnunitamnt;
  num? uinfo1;
  num? uinfo2;
  num? uinfo3;
  num? uinfo4;
  num? uinfo5;
  num? uinfo6;
  num? uinfo7;
  num? uinfo8;
  String expdate;
  int? ratescore;
  int? cancelled;
  num? outcost;
  num? outcostcurr;
  num? diffprcost;
  num? diffprcostcurr;
  int? seriqcok;
  int? lprodstat;
  int? sourcetype;
  int? sourcewsref;
  int? siteid;
  int? recstatus;
  int? orglogicref;
  int? wfstatus;
  int? distordref;
  int? distordlnref;
  int? indordsltrnref;
  num? grossuinfo1;
  num? grossuinfo2;
  num? ataxprcost;
  num? ataxprcostcurr;
  num? infidx;
  String? orglogoid;
  String? lineexp;
  int? eximfctype;
  int? eximfileref;
  int? eximprocnr;
  int? mainsllnref;
  int? madeofshred;
  int? status;
  int? variantref;
  String? grpbegcode;
  String? grpendcode;
  num? outcostufrs;
  num? outcostcurrufrs;
  num? diffprcostufrs;
  num? diffprcostcurrufrs;
  num? infidxufrs;
  num? adjprcostufrs;
  num? adjprcostcurrufrs;
  String? guid;
  int? prdordref;
  int? prdordslplnreserve;
  int? inplnsltransref;
  int? notshipped;
  int? qctransferref;
  num? qctransferamnt;
  num? qctransferamnt2;
  String? tibbicihazurtdate;
  int? qctransferref2;
  String? specode;
  String? specode2;
  MotorTransaction({
    required this.logicalref,
    this.stficheref,
    this.sttransref,
    this.intransref,
    this.insltransref,
    this.inslamount,
    this.linenr,
    this.itemref,
    required this.datE_,
    this.iocode,
    this.invenno,
    this.fichetype,
    this.sltype,
    this.slref,
    this.locref,
    this.mainamount,
    this.uomref,
    this.amount,
    this.remamount,
    this.remlnunitamnt,
    this.uinfo1,
    this.uinfo2,
    this.uinfo3,
    this.uinfo4,
    this.uinfo5,
    this.uinfo6,
    this.uinfo7,
    this.uinfo8,
    required this.expdate,
    this.ratescore,
    this.cancelled,
    this.outcost,
    this.outcostcurr,
    this.diffprcost,
    this.diffprcostcurr,
    this.seriqcok,
    this.lprodstat,
    this.sourcetype,
    this.sourcewsref,
    this.siteid,
    this.recstatus,
    this.orglogicref,
    this.wfstatus,
    this.distordref,
    this.distordlnref,
    this.indordsltrnref,
    this.grossuinfo1,
    this.grossuinfo2,
    this.ataxprcost,
    this.ataxprcostcurr,
    this.infidx,
    this.orglogoid,
    this.lineexp,
    this.eximfctype,
    this.eximfileref,
    this.eximprocnr,
    this.mainsllnref,
    this.madeofshred,
    this.status,
    this.variantref,
    this.grpbegcode,
    this.grpendcode,
    this.outcostufrs,
    this.outcostcurrufrs,
    this.diffprcostufrs,
    this.diffprcostcurrufrs,
    this.infidxufrs,
    this.adjprcostufrs,
    this.adjprcostcurrufrs,
    this.guid,
    this.prdordref,
    this.prdordslplnreserve,
    this.inplnsltransref,
    this.notshipped,
    this.qctransferref,
    this.qctransferamnt,
    this.qctransferamnt2,
    this.tibbicihazurtdate,
    this.qctransferref2,
    this.specode,
    this.specode2,
  });

  MotorTransaction copyWith({
    int? logicalref,
    int? stficheref,
    int? sttransref,
    int? intransref,
    int? insltransref,
    num? inslamount,
    int? linenr,
    int? itemref,
    DateTime? datE_,
    int? iocode,
    int? invenno,
    int? fichetype,
    int? sltype,
    int? slref,
    int? locref,
    num? mainamount,
    int? uomref,
    num? amount,
    num? remamount,
    num? remlnunitamnt,
    num? uinfo1,
    num? uinfo2,
    num? uinfo3,
    num? uinfo4,
    num? uinfo5,
    num? uinfo6,
    num? uinfo7,
    num? uinfo8,
    String? expdate,
    int? ratescore,
    int? cancelled,
    num? outcost,
    num? outcostcurr,
    num? diffprcost,
    num? diffprcostcurr,
    int? seriqcok,
    int? lprodstat,
    int? sourcetype,
    int? sourcewsref,
    int? siteid,
    int? recstatus,
    int? orglogicref,
    int? wfstatus,
    int? distordref,
    int? distordlnref,
    int? indordsltrnref,
    num? grossuinfo1,
    num? grossuinfo2,
    num? ataxprcost,
    num? ataxprcostcurr,
    num? infidx,
    String? orglogoid,
    String? lineexp,
    int? eximfctype,
    int? eximfileref,
    int? eximprocnr,
    int? mainsllnref,
    int? madeofshred,
    int? status,
    int? variantref,
    String? grpbegcode,
    String? grpendcode,
    num? outcostufrs,
    num? outcostcurrufrs,
    num? diffprcostufrs,
    num? diffprcostcurrufrs,
    num? infidxufrs,
    num? adjprcostufrs,
    num? adjprcostcurrufrs,
    String? guid,
    int? prdordref,
    int? prdordslplnreserve,
    int? inplnsltransref,
    int? notshipped,
    int? qctransferref,
    num? qctransferamnt,
    num? qctransferamnt2,
    String? tibbicihazurtdate,
    int? qctransferref2,
    String? specode,
    String? specode2,
  }) {
    return MotorTransaction(
      logicalref: logicalref ?? this.logicalref,
      stficheref: stficheref ?? this.stficheref,
      sttransref: sttransref ?? this.sttransref,
      intransref: intransref ?? this.intransref,
      insltransref: insltransref ?? this.insltransref,
      inslamount: inslamount ?? this.inslamount,
      linenr: linenr ?? this.linenr,
      itemref: itemref ?? this.itemref,
      datE_: datE_ ?? this.datE_,
      iocode: iocode ?? this.iocode,
      invenno: invenno ?? this.invenno,
      fichetype: fichetype ?? this.fichetype,
      sltype: sltype ?? this.sltype,
      slref: slref ?? this.slref,
      locref: locref ?? this.locref,
      mainamount: mainamount ?? this.mainamount,
      uomref: uomref ?? this.uomref,
      amount: amount ?? this.amount,
      remamount: remamount ?? this.remamount,
      remlnunitamnt: remlnunitamnt ?? this.remlnunitamnt,
      uinfo1: uinfo1 ?? this.uinfo1,
      uinfo2: uinfo2 ?? this.uinfo2,
      uinfo3: uinfo3 ?? this.uinfo3,
      uinfo4: uinfo4 ?? this.uinfo4,
      uinfo5: uinfo5 ?? this.uinfo5,
      uinfo6: uinfo6 ?? this.uinfo6,
      uinfo7: uinfo7 ?? this.uinfo7,
      uinfo8: uinfo8 ?? this.uinfo8,
      expdate: expdate ?? this.expdate,
      ratescore: ratescore ?? this.ratescore,
      cancelled: cancelled ?? this.cancelled,
      outcost: outcost ?? this.outcost,
      outcostcurr: outcostcurr ?? this.outcostcurr,
      diffprcost: diffprcost ?? this.diffprcost,
      diffprcostcurr: diffprcostcurr ?? this.diffprcostcurr,
      seriqcok: seriqcok ?? this.seriqcok,
      lprodstat: lprodstat ?? this.lprodstat,
      sourcetype: sourcetype ?? this.sourcetype,
      sourcewsref: sourcewsref ?? this.sourcewsref,
      siteid: siteid ?? this.siteid,
      recstatus: recstatus ?? this.recstatus,
      orglogicref: orglogicref ?? this.orglogicref,
      wfstatus: wfstatus ?? this.wfstatus,
      distordref: distordref ?? this.distordref,
      distordlnref: distordlnref ?? this.distordlnref,
      indordsltrnref: indordsltrnref ?? this.indordsltrnref,
      grossuinfo1: grossuinfo1 ?? this.grossuinfo1,
      grossuinfo2: grossuinfo2 ?? this.grossuinfo2,
      ataxprcost: ataxprcost ?? this.ataxprcost,
      ataxprcostcurr: ataxprcostcurr ?? this.ataxprcostcurr,
      infidx: infidx ?? this.infidx,
      orglogoid: orglogoid ?? this.orglogoid,
      lineexp: lineexp ?? this.lineexp,
      eximfctype: eximfctype ?? this.eximfctype,
      eximfileref: eximfileref ?? this.eximfileref,
      eximprocnr: eximprocnr ?? this.eximprocnr,
      mainsllnref: mainsllnref ?? this.mainsllnref,
      madeofshred: madeofshred ?? this.madeofshred,
      status: status ?? this.status,
      variantref: variantref ?? this.variantref,
      grpbegcode: grpbegcode ?? this.grpbegcode,
      grpendcode: grpendcode ?? this.grpendcode,
      outcostufrs: outcostufrs ?? this.outcostufrs,
      outcostcurrufrs: outcostcurrufrs ?? this.outcostcurrufrs,
      diffprcostufrs: diffprcostufrs ?? this.diffprcostufrs,
      diffprcostcurrufrs: diffprcostcurrufrs ?? this.diffprcostcurrufrs,
      infidxufrs: infidxufrs ?? this.infidxufrs,
      adjprcostufrs: adjprcostufrs ?? this.adjprcostufrs,
      adjprcostcurrufrs: adjprcostcurrufrs ?? this.adjprcostcurrufrs,
      guid: guid ?? this.guid,
      prdordref: prdordref ?? this.prdordref,
      prdordslplnreserve: prdordslplnreserve ?? this.prdordslplnreserve,
      inplnsltransref: inplnsltransref ?? this.inplnsltransref,
      notshipped: notshipped ?? this.notshipped,
      qctransferref: qctransferref ?? this.qctransferref,
      qctransferamnt: qctransferamnt ?? this.qctransferamnt,
      qctransferamnt2: qctransferamnt2 ?? this.qctransferamnt2,
      tibbicihazurtdate: tibbicihazurtdate ?? this.tibbicihazurtdate,
      qctransferref2: qctransferref2 ?? this.qctransferref2,
      specode: specode ?? this.specode,
      specode2: specode2 ?? this.specode2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logicalref': logicalref,
      'stficheref': stficheref,
      'sttransref': sttransref,
      'intransref': intransref,
      'insltransref': insltransref,
      'inslamount': inslamount,
      'linenr': linenr,
      'itemref': itemref,
      'datE_': datE_,
      'iocode': iocode,
      'invenno': invenno,
      'fichetype': fichetype,
      'sltype': sltype,
      'slref': slref,
      'locref': locref,
      'mainamount': mainamount,
      'uomref': uomref,
      'amount': amount,
      'remamount': remamount,
      'remlnunitamnt': remlnunitamnt,
      'uinfo1': uinfo1,
      'uinfo2': uinfo2,
      'uinfo3': uinfo3,
      'uinfo4': uinfo4,
      'uinfo5': uinfo5,
      'uinfo6': uinfo6,
      'uinfo7': uinfo7,
      'uinfo8': uinfo8,
      'expdate': expdate,
      'ratescore': ratescore,
      'cancelled': cancelled,
      'outcost': outcost,
      'outcostcurr': outcostcurr,
      'diffprcost': diffprcost,
      'diffprcostcurr': diffprcostcurr,
      'seriqcok': seriqcok,
      'lprodstat': lprodstat,
      'sourcetype': sourcetype,
      'sourcewsref': sourcewsref,
      'siteid': siteid,
      'recstatus': recstatus,
      'orglogicref': orglogicref,
      'wfstatus': wfstatus,
      'distordref': distordref,
      'distordlnref': distordlnref,
      'indordsltrnref': indordsltrnref,
      'grossuinfo1': grossuinfo1,
      'grossuinfo2': grossuinfo2,
      'ataxprcost': ataxprcost,
      'ataxprcostcurr': ataxprcostcurr,
      'infidx': infidx,
      'orglogoid': orglogoid,
      'lineexp': lineexp,
      'eximfctype': eximfctype,
      'eximfileref': eximfileref,
      'eximprocnr': eximprocnr,
      'mainsllnref': mainsllnref,
      'madeofshred': madeofshred,
      'status': status,
      'variantref': variantref,
      'grpbegcode': grpbegcode,
      'grpendcode': grpendcode,
      'outcostufrs': outcostufrs,
      'outcostcurrufrs': outcostcurrufrs,
      'diffprcostufrs': diffprcostufrs,
      'diffprcostcurrufrs': diffprcostcurrufrs,
      'infidxufrs': infidxufrs,
      'adjprcostufrs': adjprcostufrs,
      'adjprcostcurrufrs': adjprcostcurrufrs,
      'guid': guid,
      'prdordref': prdordref,
      'prdordslplnreserve': prdordslplnreserve,
      'inplnsltransref': inplnsltransref,
      'notshipped': notshipped,
      'qctransferref': qctransferref,
      'qctransferamnt': qctransferamnt,
      'qctransferamnt2': qctransferamnt2,
      'tibbicihazurtdate': tibbicihazurtdate,
      'qctransferref2': qctransferref2,
      'specode': specode,
      'specode2': specode2,
    };
  }

  factory MotorTransaction.fromMap(Map<String, dynamic> map) {
    return MotorTransaction(
      logicalref: map['logicalref'] as int,
      stficheref: map['stficheref'] != null ? map['stficheref'] as int : null,
      sttransref: map['sttransref'] != null ? map['sttransref'] as int : null,
      intransref: map['intransref'] != null ? map['intransref'] as int : null,
      insltransref: map['insltransref'] != null
          ? map['insltransref'] as int
          : null,
      inslamount: map['inslamount'] != null ? map['inslamount'] as num : null,
      linenr: map['linenr'] != null ? map['linenr'] as int : null,
      itemref: map['itemref'] != null ? map['itemref'] as int : null,
      datE_: DateTime.parse(map['datE_'] as String),
      iocode: map['iocode'] != null ? map['iocode'] as int : null,
      invenno: map['invenno'] != null ? map['invenno'] as int : null,
      fichetype: map['fichetype'] != null ? map['fichetype'] as int : null,
      sltype: map['sltype'] != null ? map['sltype'] as int : null,
      slref: map['slref'] != null ? map['slref'] as int : null,
      locref: map['locref'] != null ? map['locref'] as int : null,
      mainamount: map['mainamount'] != null ? map['mainamount'] as num : null,
      uomref: map['uomref'] != null ? map['uomref'] as int : null,
      amount: map['amount'] != null ? map['amount'] as num : null,
      remamount: map['remamount'] != null ? map['remamount'] as num : null,
      remlnunitamnt: map['remlnunitamnt'] != null
          ? map['remlnunitamnt'] as num
          : null,
      uinfo1: map['uinfo1'] != null ? map['uinfo1'] as num : null,
      uinfo2: map['uinfo2'] != null ? map['uinfo2'] as num : null,
      uinfo3: map['uinfo3'] != null ? map['uinfo3'] as num : null,
      uinfo4: map['uinfo4'] != null ? map['uinfo4'] as num : null,
      uinfo5: map['uinfo5'] != null ? map['uinfo5'] as num : null,
      uinfo6: map['uinfo6'] != null ? map['uinfo6'] as num : null,
      uinfo7: map['uinfo7'] != null ? map['uinfo7'] as num : null,
      uinfo8: map['uinfo8'] != null ? map['uinfo8'] as num : null,
      expdate: map['expdate'] as String,
      ratescore: map['ratescore'] != null ? map['ratescore'] as int : null,
      cancelled: map['cancelled'] != null ? map['cancelled'] as int : null,
      outcost: map['outcost'] != null ? map['outcost'] as num : null,
      outcostcurr: map['outcostcurr'] != null
          ? map['outcostcurr'] as num
          : null,
      diffprcost: map['diffprcost'] != null ? map['diffprcost'] as num : null,
      diffprcostcurr: map['diffprcostcurr'] != null
          ? map['diffprcostcurr'] as num
          : null,
      seriqcok: map['seriqcok'] != null ? map['seriqcok'] as int : null,
      lprodstat: map['lprodstat'] != null ? map['lprodstat'] as int : null,
      sourcetype: map['sourcetype'] != null ? map['sourcetype'] as int : null,
      sourcewsref: map['sourcewsref'] != null
          ? map['sourcewsref'] as int
          : null,
      siteid: map['siteid'] != null ? map['siteid'] as int : null,
      recstatus: map['recstatus'] != null ? map['recstatus'] as int : null,
      orglogicref: map['orglogicref'] != null
          ? map['orglogicref'] as int
          : null,
      wfstatus: map['wfstatus'] != null ? map['wfstatus'] as int : null,
      distordref: map['distordref'] != null ? map['distordref'] as int : null,
      distordlnref: map['distordlnref'] != null
          ? map['distordlnref'] as int
          : null,
      indordsltrnref: map['indordsltrnref'] != null
          ? map['indordsltrnref'] as int
          : null,
      grossuinfo1: map['grossuinfo1'] != null
          ? map['grossuinfo1'] as num
          : null,
      grossuinfo2: map['grossuinfo2'] != null
          ? map['grossuinfo2'] as num
          : null,
      ataxprcost: map['ataxprcost'] != null ? map['ataxprcost'] as num : null,
      ataxprcostcurr: map['ataxprcostcurr'] != null
          ? map['ataxprcostcurr'] as num
          : null,
      infidx: map['infidx'] != null ? map['infidx'] as num : null,
      orglogoid: map['orglogoid'] != null ? map['orglogoid'] as String : null,
      lineexp: map['lineexp'] != null ? map['lineexp'] as String : null,
      eximfctype: map['eximfctype'] != null ? map['eximfctype'] as int : null,
      eximfileref: map['eximfileref'] != null
          ? map['eximfileref'] as int
          : null,
      eximprocnr: map['eximprocnr'] != null ? map['eximprocnr'] as int : null,
      mainsllnref: map['mainsllnref'] != null
          ? map['mainsllnref'] as int
          : null,
      madeofshred: map['madeofshred'] != null
          ? map['madeofshred'] as int
          : null,
      status: map['status'] != null ? map['status'] as int : null,
      variantref: map['variantref'] != null ? map['variantref'] as int : null,
      grpbegcode: map['grpbegcode'] != null
          ? map['grpbegcode'] as String
          : null,
      grpendcode: map['grpendcode'] != null
          ? map['grpendcode'] as String
          : null,
      outcostufrs: map['outcostufrs'] != null
          ? map['outcostufrs'] as num
          : null,
      outcostcurrufrs: map['outcostcurrufrs'] != null
          ? map['outcostcurrufrs'] as num
          : null,
      diffprcostufrs: map['diffprcostufrs'] != null
          ? map['diffprcostufrs'] as num
          : null,
      diffprcostcurrufrs: map['diffprcostcurrufrs'] != null
          ? map['diffprcostcurrufrs'] as num
          : null,
      infidxufrs: map['infidxufrs'] != null ? map['infidxufrs'] as num : null,
      adjprcostufrs: map['adjprcostufrs'] != null
          ? map['adjprcostufrs'] as num
          : null,
      adjprcostcurrufrs: map['adjprcostcurrufrs'] != null
          ? map['adjprcostcurrufrs'] as num
          : null,
      guid: map['guid'] != null ? map['guid'] as String : null,
      prdordref: map['prdordref'] != null ? map['prdordref'] as int : null,
      prdordslplnreserve: map['prdordslplnreserve'] != null
          ? map['prdordslplnreserve'] as int
          : null,
      inplnsltransref: map['inplnsltransref'] != null
          ? map['inplnsltransref'] as int
          : null,
      notshipped: map['notshipped'] != null ? map['notshipped'] as int : null,
      qctransferref: map['qctransferref'] != null
          ? map['qctransferref'] as int
          : null,
      qctransferamnt: map['qctransferamnt'] != null
          ? map['qctransferamnt'] as num
          : null,
      qctransferamnt2: map['qctransferamnt2'] != null
          ? map['qctransferamnt2'] as num
          : null,
      tibbicihazurtdate: map['tibbicihazurtdate'] != null
          ? map['tibbicihazurtdate'] as String
          : null,
      qctransferref2: map['qctransferref2'] != null
          ? map['qctransferref2'] as int
          : null,
      specode: map['specode'] != null ? map['specode'] as String : null,
      specode2: map['specode2'] != null ? map['specode2'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MotorTransaction.fromJson(String source) =>
      MotorTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MotorTransaction(logicalref: $logicalref, stficheref: $stficheref, sttransref: $sttransref, intransref: $intransref, insltransref: $insltransref, inslamount: $inslamount, linenr: $linenr, itemref: $itemref, datE_: $datE_, iocode: $iocode, invenno: $invenno, fichetype: $fichetype, sltype: $sltype, slref: $slref, locref: $locref, mainamount: $mainamount, uomref: $uomref, amount: $amount, remamount: $remamount, remlnunitamnt: $remlnunitamnt, uinfo1: $uinfo1, uinfo2: $uinfo2, uinfo3: $uinfo3, uinfo4: $uinfo4, uinfo5: $uinfo5, uinfo6: $uinfo6, uinfo7: $uinfo7, uinfo8: $uinfo8, expdate: $expdate, ratescore: $ratescore, cancelled: $cancelled, outcost: $outcost, outcostcurr: $outcostcurr, diffprcost: $diffprcost, diffprcostcurr: $diffprcostcurr, seriqcok: $seriqcok, lprodstat: $lprodstat, sourcetype: $sourcetype, sourcewsref: $sourcewsref, siteid: $siteid, recstatus: $recstatus, orglogicref: $orglogicref, wfstatus: $wfstatus, distordref: $distordref, distordlnref: $distordlnref, indordsltrnref: $indordsltrnref, grossuinfo1: $grossuinfo1, grossuinfo2: $grossuinfo2, ataxprcost: $ataxprcost, ataxprcostcurr: $ataxprcostcurr, infidx: $infidx, orglogoid: $orglogoid, lineexp: $lineexp, eximfctype: $eximfctype, eximfileref: $eximfileref, eximprocnr: $eximprocnr, mainsllnref: $mainsllnref, madeofshred: $madeofshred, status: $status, variantref: $variantref, grpbegcode: $grpbegcode, grpendcode: $grpendcode, outcostufrs: $outcostufrs, outcostcurrufrs: $outcostcurrufrs, diffprcostufrs: $diffprcostufrs, diffprcostcurrufrs: $diffprcostcurrufrs, infidxufrs: $infidxufrs, adjprcostufrs: $adjprcostufrs, adjprcostcurrufrs: $adjprcostcurrufrs, guid: $guid, prdordref: $prdordref, prdordslplnreserve: $prdordslplnreserve, inplnsltransref: $inplnsltransref, notshipped: $notshipped, qctransferref: $qctransferref, qctransferamnt: $qctransferamnt, qctransferamnt2: $qctransferamnt2, tibbicihazurtdate: $tibbicihazurtdate, qctransferref2: $qctransferref2, specode: $specode, specode2: $specode2)';
  }

  @override
  bool operator ==(covariant MotorTransaction other) {
    if (identical(this, other)) return true;

    return other.logicalref == logicalref &&
        other.stficheref == stficheref &&
        other.sttransref == sttransref &&
        other.intransref == intransref &&
        other.insltransref == insltransref &&
        other.inslamount == inslamount &&
        other.linenr == linenr &&
        other.itemref == itemref &&
        other.datE_ == datE_ &&
        other.iocode == iocode &&
        other.invenno == invenno &&
        other.fichetype == fichetype &&
        other.sltype == sltype &&
        other.slref == slref &&
        other.locref == locref &&
        other.mainamount == mainamount &&
        other.uomref == uomref &&
        other.amount == amount &&
        other.remamount == remamount &&
        other.remlnunitamnt == remlnunitamnt &&
        other.uinfo1 == uinfo1 &&
        other.uinfo2 == uinfo2 &&
        other.uinfo3 == uinfo3 &&
        other.uinfo4 == uinfo4 &&
        other.uinfo5 == uinfo5 &&
        other.uinfo6 == uinfo6 &&
        other.uinfo7 == uinfo7 &&
        other.uinfo8 == uinfo8 &&
        other.expdate == expdate &&
        other.ratescore == ratescore &&
        other.cancelled == cancelled &&
        other.outcost == outcost &&
        other.outcostcurr == outcostcurr &&
        other.diffprcost == diffprcost &&
        other.diffprcostcurr == diffprcostcurr &&
        other.seriqcok == seriqcok &&
        other.lprodstat == lprodstat &&
        other.sourcetype == sourcetype &&
        other.sourcewsref == sourcewsref &&
        other.siteid == siteid &&
        other.recstatus == recstatus &&
        other.orglogicref == orglogicref &&
        other.wfstatus == wfstatus &&
        other.distordref == distordref &&
        other.distordlnref == distordlnref &&
        other.indordsltrnref == indordsltrnref &&
        other.grossuinfo1 == grossuinfo1 &&
        other.grossuinfo2 == grossuinfo2 &&
        other.ataxprcost == ataxprcost &&
        other.ataxprcostcurr == ataxprcostcurr &&
        other.infidx == infidx &&
        other.orglogoid == orglogoid &&
        other.lineexp == lineexp &&
        other.eximfctype == eximfctype &&
        other.eximfileref == eximfileref &&
        other.eximprocnr == eximprocnr &&
        other.mainsllnref == mainsllnref &&
        other.madeofshred == madeofshred &&
        other.status == status &&
        other.variantref == variantref &&
        other.grpbegcode == grpbegcode &&
        other.grpendcode == grpendcode &&
        other.outcostufrs == outcostufrs &&
        other.outcostcurrufrs == outcostcurrufrs &&
        other.diffprcostufrs == diffprcostufrs &&
        other.diffprcostcurrufrs == diffprcostcurrufrs &&
        other.infidxufrs == infidxufrs &&
        other.adjprcostufrs == adjprcostufrs &&
        other.adjprcostcurrufrs == adjprcostcurrufrs &&
        other.guid == guid &&
        other.prdordref == prdordref &&
        other.prdordslplnreserve == prdordslplnreserve &&
        other.inplnsltransref == inplnsltransref &&
        other.notshipped == notshipped &&
        other.qctransferref == qctransferref &&
        other.qctransferamnt == qctransferamnt &&
        other.qctransferamnt2 == qctransferamnt2 &&
        other.tibbicihazurtdate == tibbicihazurtdate &&
        other.qctransferref2 == qctransferref2 &&
        other.specode == specode &&
        other.specode2 == specode2;
  }

  @override
  int get hashCode {
    return logicalref.hashCode ^
        stficheref.hashCode ^
        sttransref.hashCode ^
        intransref.hashCode ^
        insltransref.hashCode ^
        inslamount.hashCode ^
        linenr.hashCode ^
        itemref.hashCode ^
        datE_.hashCode ^
        iocode.hashCode ^
        invenno.hashCode ^
        fichetype.hashCode ^
        sltype.hashCode ^
        slref.hashCode ^
        locref.hashCode ^
        mainamount.hashCode ^
        uomref.hashCode ^
        amount.hashCode ^
        remamount.hashCode ^
        remlnunitamnt.hashCode ^
        uinfo1.hashCode ^
        uinfo2.hashCode ^
        uinfo3.hashCode ^
        uinfo4.hashCode ^
        uinfo5.hashCode ^
        uinfo6.hashCode ^
        uinfo7.hashCode ^
        uinfo8.hashCode ^
        expdate.hashCode ^
        ratescore.hashCode ^
        cancelled.hashCode ^
        outcost.hashCode ^
        outcostcurr.hashCode ^
        diffprcost.hashCode ^
        diffprcostcurr.hashCode ^
        seriqcok.hashCode ^
        lprodstat.hashCode ^
        sourcetype.hashCode ^
        sourcewsref.hashCode ^
        siteid.hashCode ^
        recstatus.hashCode ^
        orglogicref.hashCode ^
        wfstatus.hashCode ^
        distordref.hashCode ^
        distordlnref.hashCode ^
        indordsltrnref.hashCode ^
        grossuinfo1.hashCode ^
        grossuinfo2.hashCode ^
        ataxprcost.hashCode ^
        ataxprcostcurr.hashCode ^
        infidx.hashCode ^
        orglogoid.hashCode ^
        lineexp.hashCode ^
        eximfctype.hashCode ^
        eximfileref.hashCode ^
        eximprocnr.hashCode ^
        mainsllnref.hashCode ^
        madeofshred.hashCode ^
        status.hashCode ^
        variantref.hashCode ^
        grpbegcode.hashCode ^
        grpendcode.hashCode ^
        outcostufrs.hashCode ^
        outcostcurrufrs.hashCode ^
        diffprcostufrs.hashCode ^
        diffprcostcurrufrs.hashCode ^
        infidxufrs.hashCode ^
        adjprcostufrs.hashCode ^
        adjprcostcurrufrs.hashCode ^
        guid.hashCode ^
        prdordref.hashCode ^
        prdordslplnreserve.hashCode ^
        inplnsltransref.hashCode ^
        notshipped.hashCode ^
        qctransferref.hashCode ^
        qctransferamnt.hashCode ^
        qctransferamnt2.hashCode ^
        tibbicihazurtdate.hashCode ^
        qctransferref2.hashCode ^
        specode.hashCode ^
        specode2.hashCode;
  }
}
