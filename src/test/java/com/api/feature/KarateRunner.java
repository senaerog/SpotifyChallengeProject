package com.api.feature;

import com.intuit.karate.junit5.Karate;

public class KarateRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("KarateRunner").relativeTo(getClass()); }
}
