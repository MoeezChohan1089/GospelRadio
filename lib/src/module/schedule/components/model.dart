class shedulemodel {
  String? status;
  Null? message;
  Data? data;

  shedulemodel({this.status, this.message, this.data});

  shedulemodel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Schedules>? schedules;

  Data({this.schedules});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(new Schedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedules {
  String? dayName;
  List<Shows>? shows;

  Schedules({this.dayName, this.shows});

  Schedules.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    if (json['shows'] != null) {
      shows = <Shows>[];
      json['shows'].forEach((v) {
        shows!.add(new Shows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_name'] = this.dayName;
    if (this.shows != null) {
      data['shows'] = this.shows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shows {
  int? id;
  int? hostId;
  String? day;
  int? showId;
  String? fromTime;
  String? toTime;
  Null? ip;
  String? createdAt;
  String? updatedAt;
  Host? host;
  Show? show;

  Shows(
      {this.id,
      this.hostId,
      this.day,
      this.showId,
      this.fromTime,
      this.toTime,
      this.ip,
      this.createdAt,
      this.updatedAt,
      this.host,
      this.show});

  Shows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostId = json['host_id'];
    day = json['day'];
    showId = json['show_id'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    ip = json['ip'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    show = json['show'] != null ? new Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['host_id'] = this.hostId;
    data['day'] = this.day;
    data['show_id'] = this.showId;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['ip'] = this.ip;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    if (this.show != null) {
      data['show'] = this.show!.toJson();
    }
    return data;
  }
}

class Host {
  int? id;
  int? roleId;
  String? name;
  String? email;
  String? avatar;
  String? emailVerifiedAt;
  Settings? settings;
  String? about;
  String? slug;
  Null? extra;
  Null? otp;
  Null? city;
  Null? state;
  Null? zip;
  Null? country;
  String? createdAt;
  String? updatedAt;
  Null? stripeId;
  Null? pmType;
  Null? pmLastFour;
  Null? trialEndsAt;
  String? avatarUrl;
  String? type;
  DjAccount? djAccount;

  Host(
      {this.id,
      this.roleId,
      this.name,
      this.email,
      this.avatar,
      this.emailVerifiedAt,
      this.settings,
      this.about,
      this.slug,
      this.extra,
      this.otp,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.pmType,
      this.pmLastFour,
      this.trialEndsAt,
      this.avatarUrl,
      this.type,
      this.djAccount});

  Host.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    emailVerifiedAt = json['email_verified_at'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    about = json['about'];
    slug = json['slug'];
    extra = json['extra'];
    otp = json['otp'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    avatarUrl = json['avatar_url'];
    type = json['type'];
    djAccount = json['dj_account'] != null
        ? new DjAccount.fromJson(json['dj_account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['email_verified_at'] = this.emailVerifiedAt;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    data['about'] = this.about;
    data['slug'] = this.slug;
    data['extra'] = this.extra;
    data['otp'] = this.otp;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['pm_type'] = this.pmType;
    data['pm_last_four'] = this.pmLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    data['avatar_url'] = this.avatarUrl;
    data['type'] = this.type;
    if (this.djAccount != null) {
      data['dj_account'] = this.djAccount!.toJson();
    }
    return data;
  }
}

class Settings {
  String? locale;

  Settings({this.locale});

  Settings.fromJson(Map<String, dynamic> json) {
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locale'] = this.locale;
    return data;
  }
}

class DjAccount {
  String? username;
  int? password;

  DjAccount({this.username, this.password});

  DjAccount.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class Show {
  int? id;
  String? name;
  String? details;
  Null? userId;
  Null? ip;
  String? slug;
  String? status;
  String? createdAt;
  String? updatedAt;

  Show(
      {this.id,
      this.name,
      this.details,
      this.userId,
      this.ip,
      this.slug,
      this.status,
      this.createdAt,
      this.updatedAt});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    userId = json['user_id'];
    ip = json['ip'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['user_id'] = this.userId;
    data['ip'] = this.ip;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
