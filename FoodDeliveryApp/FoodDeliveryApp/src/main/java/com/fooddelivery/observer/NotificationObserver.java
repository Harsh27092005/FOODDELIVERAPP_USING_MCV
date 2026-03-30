package com.fooddelivery.observer;

public class NotificationObserver implements OrderObserver {
    @Override
    public void update(int orderId, String status) {
        // Output to console for simulation/logging
        System.out.println("NOTIFICATION: Order #" + orderId + " is now " + status);
    }
}
