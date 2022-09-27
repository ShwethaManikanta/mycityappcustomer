class TrackDriverModel {
  String? status;
  String? message;
  String? orderId;
  TrackDetails? trackDetails;

  TrackDriverModel(
      {this.status, this.message, this.orderId, this.trackDetails});

  TrackDriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'];
    trackDetails = json['track_details'] != null
        ? new TrackDetails.fromJson(json['track_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['order_id'] = this.orderId;
    if (this.trackDetails != null) {
      data['track_details'] = this.trackDetails!.toJson();
    }
    return data;
  }
}

class TrackDetails {
  String? id;
  String? tripId;
  String? lat;
  String? long;
  String? address;
  String? heading;
  String? status;
  String? createdAt;

  TrackDetails(
      {this.id,
      this.tripId,
      this.lat,
      this.long,
      this.address,
      this.heading,
      this.status,
      this.createdAt});

  TrackDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripId = json['trip_id'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    heading = json['heading'] ?? "2.3";
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trip_id'] = this.tripId;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    data['heading'] = this.heading;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
