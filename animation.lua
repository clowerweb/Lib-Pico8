function anim(a,anim,offx,offy)
	if(anim.loop!=false) then
		anim.loop=true
	end

	anim.step=anim.step or 0
	
	local sta=anim.start
	local cur=anim.current or 0
	local stp=anim.step
	local spd=anim.speed
	local flx=anim.flipx
	local fly=anim.flipy
	local rst=anim.reset or 0
	local lop=anim.loop
	local rev=anim.reverse or false
	
	anim.step+=1
	stp=anim.step
	if(not rev) then
		if(stp%flr(30/spd)==0)	cur+=1
		if(cur==anim.frames) then
			if(lop) then cur=0
			else cur-=1 end
		end
	else
		if(stp%flr(30/spd)==0)	cur-=1
		if(cur<0) cur=0
	end
	
	if(a.md and not a.mv and
	not anim.imv) then
		cur=rst
	end
	
	anim.current=cur
	a.anim.play=anim
	
	if(not offx) offx=0
	if(not offy) offy=0
	
	spr(sta+cur,a.x+offx,a.y+offy,1,1,flx,fly)
end
