package examples.ui;

import com.intuit.karate.junit5.Karate;

class GithubRunner {

    @Karate.Test
    Karate testUsers() {
        return new Karate().feature("github").relativeTo(getClass());
    }
}