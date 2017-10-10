<component-canvas hidden="true">
    <canvas id="canvas">
    </canvas>
<script>
  var scope = this;
  var ctx;

  this.on('mount', function () {
    ctx = canvas.getContext("2d");
    ctx.font = 64 * widthK + "px SFUIDisplay-Light";
    fontSize = Number(ctx.font.split("px")[0]);
    if (fontSize != 64 * widthK)
    {
        ctx.font = 64 * widthK * (64 * widthK / fontSize) + "px SFUIDisplay-Light";
    }
    ctx.save();
    ctx.restore();
    scope.update();
  });

</script>
</component-canvas>