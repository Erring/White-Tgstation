/obj/item/gun/ballistic/rifle/boltaction/ptr
	name = "AMATR M4ND4"
	desc = "��� ���� ���������������� ��������������� ����� M4ND4"
	icon = 'code/shitcode/hule/icons/obj/weapons.dmi'
	icon_state = "ptr"
	item_state = "ptr"
	lefthand_file = 'code/shitcode/hule/icons/onmob/guns96_l.dmi'
	righthand_file = 'code/shitcode/hule/icons/onmob/guns96_r.dmi'
	inhand_x_dimension = -32
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/intmagptr
	can_bayonet = FALSE

/obj/item/gun/ballistic/rifle/boltaction/ptr/examine(mob/user)
	. = ..()
	var/HC = 0
	for(var/obj/item/bodypart/head/H in contents)
		HC++
	. += "<span class='notice'>����� ��������� [HC] �����.\n����������� ���������� ��� ���������� �����.</span>"

/obj/item/gun/ballistic/rifle/boltaction/ptr/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/crowbar))
		to_chat(user, "�� ����������� ��������������� ��������.")
		var/turf/T = get_turf(user)
		for(var/obj/item/bodypart/head/H in contents)
			H.forceMove(T)

/obj/item/ammo_box/magazine/internal/boltaction/intmagptr
	max_ammo = 1
	ammo_type = /obj/item/ammo_casing/a15mm
	caliber = "15mm"

/obj/item/ammo_casing/a15mm
	name = "15mm bullet casing"
	desc = "A 15mm bullet casing."
	icon = 'code/shitcode/hule/icons/obj/weapons.dmi'
	icon_state = "15mm-casing"
	caliber = "15mm"
	projectile_type = /obj/item/projectile/bullet/a15mm

/obj/item/projectile/bullet/a15mm
	name = "15mm bullet"
	damage = 99
	speed = 0.5
	dismemberment = 70
	pass_flags = PASSTABLE | PASSGRILLE

/obj/item/projectile/bullet/a15mm/on_hit(atom/target)
	. = ..()
	var/obj/item/gun/ballistic/rifle/boltaction/ptr/G = fired_from

	if(istype(target, /obj/mecha))
		target.ex_act(EXPLODE_HEAVY)
		playsound(src,'code/shitcode/hule/SFX/probitie.ogg', 100, 5, pressure_affected = FALSE)

	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(def_zone == BODY_ZONE_HEAD)
			var/obj/item/bodypart/head/H = C.get_bodypart(BODY_ZONE_HEAD)
			to_chat(C, "<span class='userdanger'>���� ������ ��������� ���������������� ��������������� ����� M4ND4!</span>")

			if(istype(firer, /mob/living/carbon))
				var/mob/living/carbon/owner = firer
				owner.killcounter.count_kill(TRUE)

			H.drop_limb()
			H.forceMove(G)
			playsound(G,'code/shitcode/hule/SFX/csSFX/headshot.wav', 100, 5, pressure_affected = FALSE)
		if(def_zone == BODY_ZONE_CHEST)
			if(prob(30))
				if(C.getorganslot(ORGAN_SLOT_HEART))
					var/list/elligible_organs = list()
					for(var/obj/item/organ/O in C.internal_organs) //make sure we dont get an implant or cavity item
						elligible_organs += O
					if(elligible_organs.len)
						var/obj/item/organ/O = pick(elligible_organs)
						O.Remove(C)
						O.forceMove(C.drop_location())
						if(prob(20))
							O.animate_atom_living()

/obj/item/ammo_box/a15mm
	name = "ammo box (15mm)"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/a15mm
	max_ammo = 10

/datum/outfit/ptrschoolshooter
	name = "Schoolshooter 2.0"

	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest/leather
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/soft/black
	suit_store = /obj/item/gun/ballistic/rifle/boltaction/ptr
	l_pocket = /obj/item/switchblade
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/ammo_box/a15mm = 3, /obj/item/grenade/syndieminibomb/concussion = 2, /obj/item/grenade/plastic/c4 = 1)

/datum/outfit/asshunter
	name = "Okhotnik Na Pedikov"

	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hostile_environment
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat/maggloves
	head = /obj/item/clothing/head/soft/black
	mask = /obj/item/clothing/mask/gas/anonist
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	r_hand = /obj/item/gun/ballistic/rifle/boltaction/ptr
	id = /obj/item/card/id/silver/reaper
	l_pocket = /obj/item/switchblade
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(	/obj/item/ammo_box/a15mm = 3,
								/obj/item/grenade/syndieminibomb/concussion = 2,
								/obj/item/grenade/plastic/c4 = 1,
								/obj/item/book/granter/spell/knock = 1,
								/obj/item/book/granter/spell/summonitem = 1,
								/obj/item/book/granter/martial/cqc = 1,
								/obj/item/tank/internals/emergency_oxygen/double = 1



								)