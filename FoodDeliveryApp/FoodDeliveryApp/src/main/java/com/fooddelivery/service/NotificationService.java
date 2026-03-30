package com.fooddelivery.service;

import com.fooddelivery.observer.OrderObserver;
import java.util.ArrayList;
import java.util.List;

public class NotificationService {
    private List<OrderObserver> observers = new ArrayList<>();

    public void addObserver(OrderObserver observer) {
        observers.add(observer);
    }

    public void notifyOrderStatusChange(int orderId, String status) {
        for (OrderObserver observer : observers) {
            observer.update(orderId, status);
        }
    }
}
