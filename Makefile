.PHONY: clean-run
clean-run:
	@echo "--------------- Clean && Run ---------------"
	make clean-get
	make run

.PHONY: run
run:
	@echo "--------------- Run ---------------"
	flutter run

.PHONY: clean-get
clean-get:
	@echo "--------------- Clean && Get ---------------"
	flutter clean && flutter pub get
	