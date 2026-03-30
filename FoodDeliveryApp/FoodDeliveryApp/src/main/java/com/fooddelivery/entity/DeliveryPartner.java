package com.fooddelivery.entity;

public class DeliveryPartner {
    private int partnerId;
    private String name;
    private String phone;
    private String currentLocation;
    private String status;

    public DeliveryPartner() {}

    public DeliveryPartner(int partnerId, String name, String phone, String currentLocation, String status) {
        this.partnerId = partnerId;
        this.name = name;
        this.phone = phone;
        this.currentLocation = currentLocation;
        this.status = status;
    }

    public int getPartnerId() { return partnerId; }
    public void setPartnerId(int partnerId) { this.partnerId = partnerId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getCurrentLocation() { return currentLocation; }
    public void setCurrentLocation(String currentLocation) { this.currentLocation = currentLocation; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
