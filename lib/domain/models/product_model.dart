import 'dart:convert';

class ProductAPiModel {
    final List<Product>? products;
    final int? total;
    final int? skip;
    final int? limit;

    ProductAPiModel({
        this.products,
        this.total,
        this.skip,
        this.limit,
    });

    ProductAPiModel copyWith({
        List<Product>? products,
        int? total,
        int? skip,
        int? limit,
    }) => 
        ProductAPiModel(
            products: products ?? this.products,
            total: total ?? this.total,
            skip: skip ?? this.skip,
            limit: limit ?? this.limit,
        );

    factory ProductAPiModel.fromRawJson(String str) => ProductAPiModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductAPiModel.fromJson(Map<String, dynamic> json) => ProductAPiModel(
        products: json["products"] == null ? [] : List<Product>.from((json["products"] as List).map((x) => Product.fromJson(x as Map<String, dynamic>))),
        total: json["total"] as int?,
        skip: json["skip"] as int?,
        limit: json["limit"] as int?,
    );

    Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Product {
    final int? id;
    final String? title;
    final String? description;
    final String? category;
    final double? price;
    final double? discountPercentage;
    final double? rating;
    final int? stock;
    final List<String>? tags;
    final String? brand;
    final String? sku;
    final int? weight;
    final Dimensions? dimensions;
    final String? warrantyInformation;
    final ShippingInformation? shippingInformation;
    final AvailabilityStatus? availabilityStatus;
    final List<Review>? reviews;
    final ReturnPolicy? returnPolicy;
    final int? minimumOrderQuantity;
    final Meta? meta;
    final List<String>? images;
    final String? thumbnail;

    Product({
        this.id,
        this.title,
        this.description,
        this.category,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.tags,
        this.brand,
        this.sku,
        this.weight,
        this.dimensions,
        this.warrantyInformation,
        this.shippingInformation,
        this.availabilityStatus,
        this.reviews,
        this.returnPolicy,
        this.minimumOrderQuantity,
        this.meta,
        this.images,
        this.thumbnail,
    });

    Product copyWith({
        int? id,
        String? title,
        String? description,
        String? category,
        double? price,
        double? discountPercentage,
        double? rating,
        int? stock,
        List<String>? tags,
        String? brand,
        String? sku,
        int? weight,
        Dimensions? dimensions,
        String? warrantyInformation,
        ShippingInformation? shippingInformation,
        AvailabilityStatus? availabilityStatus,
        List<Review>? reviews,
        ReturnPolicy? returnPolicy,
        int? minimumOrderQuantity,
        Meta? meta,
        List<String>? images,
        String? thumbnail,
    }) => 
        Product(
            id: id ?? this.id,
            title: title ?? this.title,
            description: description ?? this.description,
            category: category ?? this.category,
            price: price ?? this.price,
            discountPercentage: discountPercentage ?? this.discountPercentage,
            rating: rating ?? this.rating,
            stock: stock ?? this.stock,
            tags: tags ?? this.tags,
            brand: brand ?? this.brand,
            sku: sku ?? this.sku,
            weight: weight ?? this.weight,
            dimensions: dimensions ?? this.dimensions,
            warrantyInformation: warrantyInformation ?? this.warrantyInformation,
            shippingInformation: shippingInformation ?? this.shippingInformation,
            availabilityStatus: availabilityStatus ?? this.availabilityStatus,
            reviews: reviews ?? this.reviews,
            returnPolicy: returnPolicy ?? this.returnPolicy,
            minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
            meta: meta ?? this.meta,
            images: images ?? this.images,
            thumbnail: thumbnail ?? this.thumbnail,
        );

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] as int?,
        title: json["title"]?.toString(),
        description: json["description"]?.toString(),
        category: json["category"]?.toString(),
        price: (json["price"] as num?)?.toDouble(),
        discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),
        rating: (json["rating"] as num?)?.toDouble(),
        stock: json["stock"] as int?,
        tags: json["tags"] == null ? [] : List<String>.from((json["tags"] as List).map((x) => x.toString())),
        brand: json["brand"]?.toString(),
        sku: json["sku"]?.toString(),
        weight: json["weight"] as int?,
        dimensions: json["dimensions"] == null ? null : Dimensions.fromJson(json["dimensions"] as Map<String, dynamic>),
        warrantyInformation: json["warrantyInformation"]?.toString(),
        shippingInformation: json["shippingInformation"] == null ? null : shippingInformationValues.map[json["shippingInformation"] as String]!,
        availabilityStatus: json["availabilityStatus"] == null ? null : availabilityStatusValues.map[json["availabilityStatus"] as String]!,
        reviews: json["reviews"] == null ? [] : List<Review>.from((json["reviews"] as List).map((x) => Review.fromJson(x as Map<String, dynamic>))),
        returnPolicy: json["returnPolicy"] == null ? null : returnPolicyValues.map[json["returnPolicy"] as String]!,
        minimumOrderQuantity: json["minimumOrderQuantity"] as int?,
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"] as Map<String, dynamic>),
        images: json["images"] == null ? [] : List<String>.from((json["images"] as List).map((x) => x.toString())),
        thumbnail: json["thumbnail"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "brand": brand,
        "sku": sku,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "warrantyInformation": warrantyInformation,
        "shippingInformation": shippingInformationValues.reverse[shippingInformation],
        "availabilityStatus": availabilityStatusValues.reverse[availabilityStatus],
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "returnPolicy": returnPolicyValues.reverse[returnPolicy],
        "minimumOrderQuantity": minimumOrderQuantity,
        "meta": meta?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail,
    };
}

enum AvailabilityStatus {
    IN_STOCK,
    LOW_STOCK
}

final availabilityStatusValues = EnumValues({
    "In Stock": AvailabilityStatus.IN_STOCK,
    "Low Stock": AvailabilityStatus.LOW_STOCK
});

class Dimensions {
    final double? width;
    final double? height;
    final double? depth;

    Dimensions({
        this.width,
        this.height,
        this.depth,
    });

    Dimensions copyWith({
        double? width,
        double? height,
        double? depth,
    }) => 
        Dimensions(
            width: width ?? this.width,
            height: height ?? this.height,
            depth: depth ?? this.depth,
        );

    factory Dimensions.fromRawJson(String str) => Dimensions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
    };
}

class Meta {
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? barcode;
    final String? qrCode;

    Meta({
        this.createdAt,
        this.updatedAt,
        this.barcode,
        this.qrCode,
    });

    Meta copyWith({
        DateTime? createdAt,
        DateTime? updatedAt,
        String? barcode,
        String? qrCode,
    }) => 
        Meta(
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            barcode: barcode ?? this.barcode,
            qrCode: qrCode ?? this.qrCode,
        );

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        barcode: json["barcode"],
        qrCode: json["qrCode"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "barcode": barcode,
        "qrCode": qrCode,
    };
}

enum ReturnPolicy {
    NO_RETURN_POLICY,
    THE_30_DAYS_RETURN_POLICY,
    THE_60_DAYS_RETURN_POLICY,
    THE_7_DAYS_RETURN_POLICY,
    THE_90_DAYS_RETURN_POLICY
}

final returnPolicyValues = EnumValues({
    "No return policy": ReturnPolicy.NO_RETURN_POLICY,
    "30 days return policy": ReturnPolicy.THE_30_DAYS_RETURN_POLICY,
    "60 days return policy": ReturnPolicy.THE_60_DAYS_RETURN_POLICY,
    "7 days return policy": ReturnPolicy.THE_7_DAYS_RETURN_POLICY,
    "90 days return policy": ReturnPolicy.THE_90_DAYS_RETURN_POLICY
});

class Review {
    final int? rating;
    final String? comment;
    final DateTime? date;
    final String? reviewerName;
    final String? reviewerEmail;

    Review({
        this.rating,
        this.comment,
        this.date,
        this.reviewerName,
        this.reviewerEmail,
    });

    Review copyWith({
        int? rating,
        String? comment,
        DateTime? date,
        String? reviewerName,
        String? reviewerEmail,
    }) => 
        Review(
            rating: rating ?? this.rating,
            comment: comment ?? this.comment,
            date: date ?? this.date,
            reviewerName: reviewerName ?? this.reviewerName,
            reviewerEmail: reviewerEmail ?? this.reviewerEmail,
        );

    factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        comment: json["comment"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date?.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
    };
}

enum ShippingInformation {
    SHIPS_IN_12_BUSINESS_DAYS,
    SHIPS_IN_1_MONTH,
    SHIPS_IN_1_WEEK,
    SHIPS_IN_2_WEEKS,
    SHIPS_IN_35_BUSINESS_DAYS,
    SHIPS_OVERNIGHT
}

final shippingInformationValues = EnumValues({
    "Ships in 1-2 business days": ShippingInformation.SHIPS_IN_12_BUSINESS_DAYS,
    "Ships in 1 month": ShippingInformation.SHIPS_IN_1_MONTH,
    "Ships in 1 week": ShippingInformation.SHIPS_IN_1_WEEK,
    "Ships in 2 weeks": ShippingInformation.SHIPS_IN_2_WEEKS,
    "Ships in 3-5 business days": ShippingInformation.SHIPS_IN_35_BUSINESS_DAYS,
    "Ships overnight": ShippingInformation.SHIPS_OVERNIGHT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
} 