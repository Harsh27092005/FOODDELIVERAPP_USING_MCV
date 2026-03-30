package com.fooddelivery.observer;

public interface OrderObserver {
    void update(int orderId, String status);
}
