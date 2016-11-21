window.fakedSocket.register("device.register.request", function (input) {
  console.log("Input of REGISTER REQUEST " ,input);
  return {"confirm_needed": true, "device_id": "9989094641336AC091D93CD5E", "language": "UZ"};
});

window.fakedSocket.register("device.register.confirm", function (input) {
  console.log("Called method : device.register.requestTest");
  return {"confirm_needed": true, "device_id": "9989094641336AC091D93CD5E", "language": "KZ"};
});


