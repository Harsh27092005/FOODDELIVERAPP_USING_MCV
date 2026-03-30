package com.fooddelivery.service;

import com.fooddelivery.entity.User;
import java.time.LocalTime;
import java.util.Random;

public class AISuggestionService {
    
    private static final Random random = new Random();

    public String getSuggestion(User user) {
        String name = (user != null && user.getName() != null && !user.getName().trim().isEmpty()) 
                      ? user.getName().trim() 
                      : "there";
                      
        // Extract first name for a friendly tone
        if (name.contains(" ")) {
            name = name.substring(0, name.indexOf(" "));
        }
        
        LocalTime time = LocalTime.now();
        int hour = time.getHour();
        
        if (hour >= 6 && hour < 11) {
            String[] morningOptions = {
                "Rise and shine, " + name + "! Perfect time for a healthy breakfast like Idli or Poha.",
                "Good Morning, " + name + "! How about a refreshing South Indian filter coffee to start moving?",
                "Morning, " + name + "! Fresh morning, fresh food. Grab a wholesome sandwich or wrap!"
            };
            return morningOptions[random.nextInt(morningOptions.length)];
        } else if (hour >= 11 && hour < 16) {
            String[] lunchOptions = {
                "Good Afternoon, " + name + "! Time for a hearty Lunch like Biryani or a massive Thali.",
                "Lunchtime, " + name + "! You deserve a massive feast. Check out our spicy curries.",
                "Hey " + name + ", take a break! A delicious Butter Chicken and Naan is waiting for you."
            };
            return lunchOptions[random.nextInt(lunchOptions.length)];
        } else if (hour >= 16 && hour < 19) {
            String[] snackOptions = {
                "Good Evening, " + name + "! How about some Snacks like hot Samosas or a cheesy Pizza?",
                "Evening, " + name + "! Unwind with some crispy French Fries and a thick Milkshake.",
                "Hey " + name + ", time for an evening treat! A hot cup of Chai with Pakoras sounds perfect."
            };
            return snackOptions[random.nextInt(snackOptions.length)];
        } else {
            String[] dinnerOptions = {
                "Good Night, " + name + "! Enjoy a light Dinner like warm Soups or crisp Salads before bed.",
                "Late night cravings, " + name + "? A comforting bowl of Ramen or Pasta is calling your name.",
                "Dinner time, " + name + "! Wrap up your long day with a classic Dal Tadka and Jeera Rice."
            };
            return dinnerOptions[random.nextInt(dinnerOptions.length)];
        }
    }
}
