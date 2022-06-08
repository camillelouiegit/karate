package converge.onboarding;

import com.intuit.karate.junit5.Karate;

class OnboardingRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("onboarding").relativeTo(getClass());
    }    

}
