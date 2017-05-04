-- Coming soon.
-- will contain functions for
-- manipulating the camera,
-- such as following the player
-- with smooth scrolling

--methods originally by @trasevol_dog
--transcribed/editted by @msauder

--shkx,shky need to be initialized in _init()
--call camera(shkx,shky) at start of _draw()
--and be sure to update_shake() in _update()

function add_shake(p)
  local a=rnd(1)
  shkx=p*cos(a)
  shky=p*sin(a)
end

function update_shake()
  if abs(shkx)+abs(shky)<0.5 then
    shkx,shky=0,0
  end
  shkx*=-0.4
  shky*=-0.4
end
