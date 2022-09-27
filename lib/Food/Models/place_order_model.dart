class PlaceOrderRequestModel {
  final String userId,
      itemTotal,
      deliveryFee,
      parcelCharges,
      gstTax,
      convenienceCharge,
      taxTotal,
      total,
      deliveryFees,
      address,
      lat,
      long,
      outletId,
      deliveryPartner,
      deliveryTime,
      transactionId,
      paymentId,
      signatureId;

  PlaceOrderRequestModel(
      {required this.userId,
      required this.itemTotal,
      required this.deliveryFee,
      required this.parcelCharges,
      required this.gstTax,
      required this.convenienceCharge,
      required this.taxTotal,
      required this.total,
      required this.deliveryFees,
      required this.address,
      required this.signatureId,
      required this.lat,
      required this.long,
      required this.outletId,
      required this.deliveryPartner,
      required this.deliveryTime,
      required this.transactionId,
      required this.paymentId});

  toMap() {
    return {
      'user_id': userId,
      'item_total': itemTotal,
      'delivery_fee': deliveryFee,
      'percel_charges': parcelCharges,
      'gst_tax': gstTax,
      'convenience_charge': convenienceCharge,
      'taxe_total': taxTotal,
      'total': total,
      'delivery_fees': deliveryFee,
      'address': address,
      'lat': lat,
      'long': long,
      'outlet_id': outletId,
      'delivery_partner': deliveryPartner,
      'delivery_time': deliveryTime,
      'transaction_id': transactionId,
      'payment_id': paymentId,
      // 'transaction_id': signatureId
    };
  }
}
