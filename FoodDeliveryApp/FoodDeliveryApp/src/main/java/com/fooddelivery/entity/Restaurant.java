package com.fooddelivery.entity;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String city;
    private double rating;
    private int deliveryTime;
    private boolean isVegOnly;
    private String offers;

    public Restaurant() {}

    public Restaurant(int restaurantId, String name, String city, double rating, int deliveryTime, boolean isVegOnly, String offers) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.city = city;
        this.rating = rating;
        this.deliveryTime = deliveryTime;
        this.isVegOnly = isVegOnly;
        this.offers = offers;
    }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    public int getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(int deliveryTime) { this.deliveryTime = deliveryTime; }
    public boolean isVegOnly() { return isVegOnly; }
    public void setVegOnly(boolean vegOnly) { isVegOnly = vegOnly; }
    public String getOffers() { return offers; }
    public void setOffers(String offers) { this.offers = offers; }
}
