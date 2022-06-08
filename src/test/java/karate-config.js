function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = '';
  }
  var config = {
    env: env,
    baseUrl: '',
    username: '',
    password: '',
    randomEmail: '',
    randomGeneratorPath:'helpers.randomGenerator',
    loginSchemaPath:'file:src/test/java/converge/login/loginDataSchema.json',
    schemaUtilPath:'helpers.JSONSchemaUtil',
    onboardingFeature: 'classpath:converge/onboarding/onboarding.feature'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';

    config.baseUrl='https://baas.app.dev-aus.deloitteopendata.com';
    config.userName='opaque1@yopmail.com';
    config.pass='Hasher@123';

  } else if (env == 'test') {
    // customize
  }
  return config;
}