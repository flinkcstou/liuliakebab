describe("Amount transform", function() {

  it("window.amountTransform", function () {
    assert.equal(window.amountTransform('123456789'), '123 456 789');
  });
});

describe("Input verification: spaceDeleter()", function() {

  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.spaceDeleter('123   456  789'), '123456789');
  });
  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.spaceDeleter('               '), '');
  });
  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.spaceDeleter(''), '');
  });
});

describe("Input verification: telVerification()", function() {

  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.telVerification('321123456asdasd78900456'), '678900456');
  });
  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.telVerification(''), '');
  });
});

describe("Input verification: telVerificationWithSpace()", function() {

  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.telVerificationWithSpace('321123456asdasd78900456'), '56 78900456');
  });
  it("spaceDeleter()", function () {
    assert.equal(window.inputVerification.telVerificationWithSpace(''), ' ');
  });
});