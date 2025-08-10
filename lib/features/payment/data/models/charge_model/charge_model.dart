class ChargeModel {
  final bool? success;
  final ChargeData? data;

  ChargeModel({this.success, this.data});

  factory ChargeModel.fromJson(Map<String, dynamic> json) {
    return ChargeModel(
      success: json['success'],
      data: json['data'] != null ? ChargeData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data?.toJson(),
    };
  }
}

class ChargeData {
  final String? id;
  final String? object;
  final bool? liveMode;
  final bool? customerInitiated;
  final String? apiVersion;
  final String? method;
  final String? status;
  final num? amount;
  final String? currency;
  final bool? threeDSecure;
  final bool? cardThreeDSecure;
  final bool? saveCard;
  final String? product;
  final String? statementDescriptor;
  final String? description;
  final Metadata? metadata;
  final Order? order;
  final Transaction? transaction;
  final Reference? reference;
  final ResponseObj? response;
  final Gateway? gateway;
  final CardObj? card;
  final Receipt? receipt;
  final Customer? customer;
  final Merchant? merchant;
  final Source? source;
  final Redirect? redirect;
  final Authentication? authentication;
  final List<Activity>? activities;
  final bool? autoReversed;
  final Risk? risk;

  ChargeData({
    this.id,
    this.object,
    this.liveMode,
    this.customerInitiated,
    this.apiVersion,
    this.method,
    this.status,
    this.amount,
    this.currency,
    this.threeDSecure,
    this.cardThreeDSecure,
    this.saveCard,
    this.product,
    this.statementDescriptor,
    this.description,
    this.metadata,
    this.order,
    this.transaction,
    this.reference,
    this.response,
    this.gateway,
    this.card,
    this.receipt,
    this.customer,
    this.merchant,
    this.source,
    this.redirect,
    this.authentication,
    this.activities,
    this.autoReversed,
    this.risk,
  });

  factory ChargeData.fromJson(Map<String, dynamic> json) {
    return ChargeData(
      id: json['id'],
      object: json['object'],
      liveMode: json['live_mode'],
      customerInitiated: json['customer_initiated'],
      apiVersion: json['api_version'],
      method: json['method'],
      status: json['status'],
      amount: json['amount'],
      currency: json['currency'],
      threeDSecure: json['threeDSecure'],
      cardThreeDSecure: json['card_threeDSecure'],
      saveCard: json['save_card'],
      product: json['product'],
      statementDescriptor: json['statement_descriptor'],
      description: json['description'],
      metadata:
      json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      transaction: json['transaction'] != null
          ? Transaction.fromJson(json['transaction'])
          : null,
      reference: json['reference'] != null
          ? Reference.fromJson(json['reference'])
          : null,
      response: json['response'] != null
          ? ResponseObj.fromJson(json['response'])
          : null,
      gateway:
      json['gateway'] != null ? Gateway.fromJson(json['gateway']) : null,
      card: json['card'] != null ? CardObj.fromJson(json['card']) : null,
      receipt:
      json['receipt'] != null ? Receipt.fromJson(json['receipt']) : null,
      customer:
      json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      merchant:
      json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null,
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      redirect:
      json['redirect'] != null ? Redirect.fromJson(json['redirect']) : null,
      authentication: json['authentication'] != null
          ? Authentication.fromJson(json['authentication'])
          : null,
      activities: json['activities'] != null
          ? (json['activities'] as List)
          .map((e) => Activity.fromJson(e))
          .toList()
          : null,
      autoReversed: json['auto_reversed'],
      risk: json['risk'] != null ? Risk.fromJson(json['risk']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "object": object,
      "live_mode": liveMode,
      "customer_initiated": customerInitiated,
      "api_version": apiVersion,
      "method": method,
      "status": status,
      "amount": amount,
      "currency": currency,
      "threeDSecure": threeDSecure,
      "card_threeDSecure": cardThreeDSecure,
      "save_card": saveCard,
      "product": product,
      "statement_descriptor": statementDescriptor,
      "description": description,
      "metadata": metadata?.toJson(),
      "order": order?.toJson(),
      "transaction": transaction?.toJson(),
      "reference": reference?.toJson(),
      "response": response?.toJson(),
      "gateway": gateway?.toJson(),
      "card": card?.toJson(),
      "receipt": receipt?.toJson(),
      "customer": customer?.toJson(),
      "merchant": merchant?.toJson(),
      "source": source?.toJson(),
      "redirect": redirect?.toJson(),
      "authentication": authentication?.toJson(),
      "activities": activities?.map((e) => e.toJson()).toList(),
      "auto_reversed": autoReversed,
      "risk": risk?.toJson(),
    };
  }
}

class Metadata {
  final String? orderId;
  Metadata({this.orderId});
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      Metadata(orderId: json['order_id']);
  Map<String, dynamic> toJson() => {"order_id": orderId};
}

class Order {
  final String? id;
  Order({this.id});
  factory Order.fromJson(Map<String, dynamic> json) => Order(id: json['id']);
  Map<String, dynamic> toJson() => {"id": id};
}

class Transaction {
  final String? authorizationId;
  final String? timezone;
  final String? created;
  final Expiry? expiry;
  final bool? asynchronous;
  final num? amount;
  final String? currency;
  final DateObj? date;
  Transaction({
    this.authorizationId,
    this.timezone,
    this.created,
    this.expiry,
    this.asynchronous,
    this.amount,
    this.currency,
    this.date,
  });
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    authorizationId: json['authorization_id'],
    timezone: json['timezone'],
    created: json['created']?.toString(),
    expiry: json['expiry'] != null ? Expiry.fromJson(json['expiry']) : null,
    asynchronous: json['asynchronous'],
    amount: json['amount'],
    currency: json['currency'],
    date: json['date'] != null ? DateObj.fromJson(json['date']) : null,
  );
  Map<String, dynamic> toJson() => {
    "authorization_id": authorizationId,
    "timezone": timezone,
    "created": created,
    "expiry": expiry?.toJson(),
    "asynchronous": asynchronous,
    "amount": amount,
    "currency": currency,
    "date": date?.toJson(),
  };
}

class Expiry {
  final int? period;
  final String? type;
  Expiry({this.period, this.type});
  factory Expiry.fromJson(Map<String, dynamic> json) =>
      Expiry(period: json['period'], type: json['type']);
  Map<String, dynamic> toJson() => {"period": period, "type": type};
}

class DateObj {
  final int? created;
  final int? completed;
  final int? transaction;
  DateObj({this.created, this.completed, this.transaction});
  factory DateObj.fromJson(Map<String, dynamic> json) => DateObj(
    created: json['created'],
    completed: json['completed'],
    transaction: json['transaction'],
  );
  Map<String, dynamic> toJson() => {
    "created": created,
    "completed": completed,
    "transaction": transaction,
  };
}

class Reference {
  final String? track;
  final String? payment;
  final String? transaction;
  final String? order;
  final String? acquirer;
  final String? gateway;
  Reference({
    this.track,
    this.payment,
    this.transaction,
    this.order,
    this.acquirer,
    this.gateway,
  });
  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
    track: json['track'],
    payment: json['payment'],
    transaction: json['transaction'],
    order: json['order'],
    acquirer: json['acquirer'],
    gateway: json['gateway'],
  );
  Map<String, dynamic> toJson() => {
    "track": track,
    "payment": payment,
    "transaction": transaction,
    "order": order,
    "acquirer": acquirer,
    "gateway": gateway,
  };
}

class ResponseObj {
  final String? code;
  final String? message;
  ResponseObj({this.code, this.message});
  factory ResponseObj.fromJson(Map<String, dynamic> json) =>
      ResponseObj(code: json['code'], message: json['message']);
  Map<String, dynamic> toJson() => {"code": code, "message": message};
}

class Gateway {
  final ResponseObj? response;
  Gateway({this.response});
  factory Gateway.fromJson(Map<String, dynamic> json) =>
      Gateway(response: json['response'] != null
          ? ResponseObj.fromJson(json['response'])
          : null);
  Map<String, dynamic> toJson() => {"response": response?.toJson()};
}

class CardObj {
  final String? object;
  final String? firstSix;
  final String? firstEight;
  final String? scheme;
  final String? brand;
  final String? lastFour;
  CardObj({
    this.object,
    this.firstSix,
    this.firstEight,
    this.scheme,
    this.brand,
    this.lastFour,
  });
  factory CardObj.fromJson(Map<String, dynamic> json) => CardObj(
    object: json['object'],
    firstSix: json['first_six'],
    firstEight: json['first_eight'],
    scheme: json['scheme'],
    brand: json['brand'],
    lastFour: json['last_four'],
  );
  Map<String, dynamic> toJson() => {
    "object": object,
    "first_six": firstSix,
    "first_eight": firstEight,
    "scheme": scheme,
    "brand": brand,
    "last_four": lastFour,
  };
}

class Receipt {
  final String? id;
  final bool? email;
  final bool? sms;
  Receipt({this.id, this.email, this.sms});
  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
    id: json['id'],
    email: json['email'],
    sms: json['sms'],
  );
  Map<String, dynamic> toJson() => {"id": id, "email": email, "sms": sms};
}

class Customer {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Phone? phone;
  Customer({this.id, this.firstName, this.lastName, this.email, this.phone});
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    phone: json['phone'] != null ? Phone.fromJson(json['phone']) : null,
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone?.toJson(),
  };
}

class Phone {
  final String? countryCode;
  final String? number;
  Phone({this.countryCode, this.number});
  factory Phone.fromJson(Map<String, dynamic> json) =>
      Phone(countryCode: json['country_code'], number: json['number']);
  Map<String, dynamic> toJson() =>
      {"country_code": countryCode, "number": number};
}

class Merchant {
  final String? country;
  final String? currency;
  final String? id;
  Merchant({this.country, this.currency, this.id});
  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    country: json['country'],
    currency: json['currency'],
    id: json['id'],
  );
  Map<String, dynamic> toJson() =>
      {"country": country, "currency": currency, "id": id};
}

class Source {
  final String? object;
  final String? type;
  final String? paymentType;
  final String? channel;
  final String? id;
  final bool? onFile;
  final String? paymentMethod;
  Source({
    this.object,
    this.type,
    this.paymentType,
    this.channel,
    this.id,
    this.onFile,
    this.paymentMethod,
  });
  factory Source.fromJson(Map<String, dynamic> json) => Source(
    object: json['object'],
    type: json['type'],
    paymentType: json['payment_type'],
    channel: json['channel'],
    id: json['id'],
    onFile: json['on_file'],
    paymentMethod: json['payment_method'],
  );
  Map<String, dynamic> toJson() => {
    "object": object,
    "type": type,
    "payment_type": paymentType,
    "channel": channel,
    "id": id,
    "on_file": onFile,
    "payment_method": paymentMethod,
  };
}

class Redirect {
  final String? status;
  final String? url;
  Redirect({this.status, this.url});
  factory Redirect.fromJson(Map<String, dynamic> json) =>
      Redirect(status: json['status'], url: json['url']);
  Map<String, dynamic> toJson() => {"status": status, "url": url};
}

class Authentication {
  final String? acsEci;
  Authentication({this.acsEci});
  factory Authentication.fromJson(Map<String, dynamic> json) =>
      Authentication(acsEci: json['acsEci']);
  Map<String, dynamic> toJson() => {"acsEci": acsEci};
}

class Activity {
  final String? id;
  final String? object;
  final int? created;
  final String? status;
  final String? currency;
  final num? amount;
  final String? remarks;
  final String? txnId;
  Activity({
    this.id,
    this.object,
    this.created,
    this.status,
    this.currency,
    this.amount,
    this.remarks,
    this.txnId,
  });
  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json['id'],
    object: json['object'],
    created: json['created'],
    status: json['status'],
    currency: json['currency'],
    amount: json['amount'],
    remarks: json['remarks'],
    txnId: json['txn_id'],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "status": status,
    "currency": currency,
    "amount": amount,
    "remarks": remarks,
    "txn_id": txnId,
  };
}

class Risk {
  final String? id;
  final bool? isInExclusionList;
  final String? status;
  final List<Rule>? rules;
  Risk({this.id, this.isInExclusionList, this.status, this.rules});
  factory Risk.fromJson(Map<String, dynamic> json) => Risk(
    id: json['id'],
    isInExclusionList: json['is_in_exclusion_list'],
    status: json['status'],
    rules: json['rules'] != null
        ? (json['rules'] as List)
        .map((e) => Rule.fromJson(e))
        .toList()
        : null,
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "is_in_exclusion_list": isInExclusionList,
    "status": status,
    "rules": rules?.map((e) => e.toJson()).toList(),
  };
}

class Rule {
  final String? id;
  final String? name;
  final String? type;
  final String? ruleGroup;
  final String? risk;
  final String? value;
  final String? decision;
  final String? status;
  Rule({
    this.id,
    this.name,
    this.type,
    this.ruleGroup,
    this.risk,
    this.value,
    this.decision,
    this.status,
  });
  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    ruleGroup: json['rule_group'],
    risk: json['risk'],
    value: json['value'],
    decision: json['decision'],
    status: json['status'],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "rule_group": ruleGroup,
    "risk": risk,
    "value": value,
    "decision": decision,
    "status": status,
  };
}
