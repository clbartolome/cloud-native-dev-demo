package com.redhat.cnd;

import java.util.concurrent.TimeUnit;

import javax.enterprise.context.ApplicationScoped;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@ApplicationScoped
public class GreetingService {

  @ConfigProperty(name = "application.greeting.message")
  String message;

  public String message() {
    try {
      TimeUnit.SECONDS.sleep(2);
    } catch (InterruptedException e) {
      System.out.println("Ignore error");
    }
    return message;
  }
}
