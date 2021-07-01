#!/bin/bash
# Welcome messages
for course in {gtn,gat}; do
	for region in {Pacific/Auckland,Europe/Amsterdam,America/New_York}; do
		sendafter=$(TZ=$region date -d "2021-06-28 8:00:00" --rfc-3339=seconds | sed 's/ /T/')
		python3 extra/template.py $region extra/welcome-${course}.json $course | \
			sed 's|ICEBREAKER|Let us know where you are from, and one fun fact about yourself!|g' \
			> "scheduled/${course}/${sendafter}-welcome.json"
	done
done

# Shift change messages
for course in {gtn,gat}; do
	for region in {Pacific/Auckland,Europe/Amsterdam,America/New_York}; do
		sendafter=$(TZ=$region date -d "2021-06-29 10:00:00" --rfc-3339=seconds | sed 's/ /T/')
		python3 extra/template.py $region extra/shift-change-${course}.json $course | \
			sed 's|ICEBREAKER|What is the coolest, most mind blowing fact (nature/people/animal etc.) you know?|g' \
			> "scheduled/${course}/${sendafter}-shift-change.json"
	done
done

for course in {gtn,gat}; do
	for region in {Pacific/Auckland,Europe/Amsterdam,America/New_York}; do
		sendafter=$(TZ=$region date -d "2021-06-30 10:00:00" --rfc-3339=seconds | sed 's/ /T/')
		python3 extra/template.py $region extra/shift-change-${course}.json $course | \
			sed 's|ICEBREAKER|What is your favorite dish (food or drink)? Bonus points for recipes!|g' \
			> "scheduled/${course}/${sendafter}-shift-change.json"
	done
done

for course in {gtn,gat}; do
	for region in {Pacific/Auckland,Europe/Amsterdam,America/New_York}; do
		sendafter=$(TZ=$region date -d "2021-07-01 10:00:00" --rfc-3339=seconds | sed 's/ /T/')
		python3 extra/template.py $region extra/shift-change-${course}.json $course | \
			sed 's|ICEBREAKER|1. If you had a time machine, what is the first place and time you would visit? why?\nOR\n2. What is your favourite book, tv show, movie or game that you would recommend to others? |g' \
			> "scheduled/${course}/${sendafter}-shift-change.json"
	done
done


# Goodbye
for course in {gtn,gat}; do
	for region in {Pacific/Auckland,Europe/Amsterdam,America/New_York}; do
		sendafter=$(TZ=$region date -d "2021-07-02 12:00:00" --rfc-3339=seconds | sed 's/ /T/')
		python3 extra/template.py $region extra/goodbye-${course}.json $course | \
			sed 's|ICEBREAKER|What has been you favourite part of this training week? And what are you looking forward to most during the rest of GCC (if you are attending)?|g' \
			> "scheduled/${course}/${sendafter}-goodbye.json"
	done
done
