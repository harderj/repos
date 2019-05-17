srcs = $(wildcard *.hs) $(wildcard Game/*.hs)
dst = starterbot.zip

pack:
	zip $(dst) $(srcs)

test:
	@echo "Compiling ..."
	@ghc Main.hs
	@echo "Success"
	@echo "Test input ..."
	@cat testinput/gamestart | ./Main
	@echo "Nothing crashed."
