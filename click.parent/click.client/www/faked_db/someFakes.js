window.fakedSocket.register("device.register.request", function (input) {
  console.log("Called method : device.register.request");
  console.log(input);
  return {"confirm_needed": false, "device_id": "9989094641336AC091D93CD5E", "language": "UZ"};
});
