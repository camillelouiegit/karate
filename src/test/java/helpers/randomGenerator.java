package helpers;

import com.github.javafaker.Faker;

public class randomGenerator {
        public static Faker faker = new Faker();

        public static void main(String[] args) {
            System.out.println(getRandomFirstName() + " " + getRandomLastName());
            System.out.println(getRandomId());
        }

        public static String getRandomEmail() {
            String email = faker.harryPotter().character().toLowerCase().trim() + faker.random().nextInt(0, 9000) + "@yopmail.com";
            String emailFinal = email.replace(" ", "");
            return emailFinal;
        }

        public static String getRandomId() {
            String id = faker.code().ean8().toString();
            return id;
        }

        public static String getRandomFirstName() {
            String firstName = faker.name().firstName();
            return firstName;
        }

        public static String getRandomLastName() {
            String lastName = faker.name().lastName();
            return lastName;
        }

        public static String getRandomMobileNumber() {
            String mobileNumber = faker.random().nextInt(0, 999999999).toString();
            return mobileNumber;
        }

        public static Boolean getRandomBoolean() {
            int number = faker.random().nextInt(0, 1);
            boolean finalResult = false;
            if (number == 1) {
                finalResult = true;
            } else if (number == 0) {
                finalResult = false;
            }
            return finalResult;
        }

        public static String getRandomDateOfBirth() {

            String finalDateOfBirth = "";

            int year = faker.random().nextInt(1970, 2006);

            int monthFirstDigit = faker.random().nextInt(0, 1);
            int monthSecondDigit = faker.random().nextInt(0, 9);
            if (monthFirstDigit == 0) {
                if (monthSecondDigit >= 1 && monthSecondDigit <= 9) {
                    String dateOfBirth = year + "-" + monthFirstDigit + monthSecondDigit;
                    finalDateOfBirth = dateOfBirth;
                }
            } else if (monthFirstDigit == 1) {
                if (monthSecondDigit >= 0 && monthSecondDigit <= 2) {
                    String dateOfBirth = year + "-" + monthFirstDigit + monthSecondDigit;
                    finalDateOfBirth = dateOfBirth;
                } else {
                    monthFirstDigit = 0;
                    String dateOfBirth = year + "-" + monthFirstDigit + monthSecondDigit;
                    finalDateOfBirth = dateOfBirth;
                }
            } else {

            }

            return finalDateOfBirth;
        }

        public static int booleanToIntConverter(boolean value) {
            int finalValue = 2;
            if (value == true) {
                finalValue = 1;
                return finalValue;
            } else if (value == false) {
                finalValue = 0;
                return finalValue;
            }
            return finalValue;
        }

    }
