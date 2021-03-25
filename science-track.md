---
layout: page
title: GCC2021 Science Training Track
track: science
---

Welcome everybody, and thank you for joining this course!

<a href="{{site.baseurl}}/workshop"><button type="button" class="btn btn-warning btn-lg">Welcome! This page is not ready yet, training will start June 28, 2021.</button></a>

Everything you need for this course can be found on this webpage. More information including
links to all training materials can be found by clicking on each session


**Schedule:** for this training week we don't have a time-based schedule, instead we provide a set of topical modules for you to choose from. This week YOU make the schedule, YOU decide which tutorials to follow. If you are new to Galaxy, we suggest you start with the *"Introduction to Galaxy"* module, followed by the *"Inroduction to NGS Analysis"* module. If you are unsure which tutorial to follow, feel free to ask for recommendations in Slack!


<br/>
**Note:** Problems viewing this page? Try the [simple view]({{site.baseurl}}/science-simpleview) instead.



{% for day in site.data.training_sessions_science %}
 {% assign daynum = day[0] %}

{% if day[1].subday %}
<h4 class="daystart" style="margin-top:2em;"> {{day[1].title}} </h4>
{% else %}
<h2 id="{{ day[0] }}" class="daystart" style="margin-top:2em;"> {{day[1].title}} </h2>
{% endif %}
<p> {{day[1].description}} </p>
<div class="accordion" id="accordion{{daynum}}">

{% for session in day[1].sessions %}
 <div class="accordion-item">
  <h2 class="accordion-header" id="heading{{daynum}}{{forloop.index0}}">
   <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse{{daynum}}{{forloop.index0}}" aria-expanded="true" aria-controls="collapse{{daynum}}{{forloop.index0}}">
        {{session.name}}
   </button>
  </h2>
  <div id="collapse{{daynum}}{{forloop.index0}}" class="accordion-collapse collapse {% if session.show  %}show{% endif %}" aria-labelledby="heading{{daynum}}{{forlop.index0}}" data-bs-parent="#accordion{{daynum}}">
   <div class="accordion-body">

   <!-- icebreaker -->
   {% if session.type == 'icebreaker' %}{% include icebreaker.html prompt=session.prompt example=session.example %}{% endif %}


   <!-- setup -->
   {% if session.type == 'setup' %}
    {% include setup.html %}
   {% endif %}

   <!-- wrapup -->
   {% if session.type == 'wrapup' %}
    {% include wrapup.html %}
   {% endif %}

    <!-- wrapup -->
   {% if session.type == 'post-event' %}
    {% include post-event.html %}
   {% endif %}


   <!-- session description
   {% if session.description %}
   <h3>Description</h3>
   <p> {{ session.description }} </p>
   {% endif %}
   -->

   <!-- speaker and video -->
   {% if session.video %}
   <h3 class="session-section"> Video {{session.type | default: "Tutorial" }} </h3>
   {% include video-session.html session=session %}
   {% else %}
   {% unless session.type == 'icebreaker' %}{% unless session.type == 'setup' %}{% unless session.type == 'wrapup' %}{% unless session.type == 'post-event' %}
   <h3 class="session-section"> Self-Study Tutorial </h3>
   {{session.description}}

   {% include selfstudy-session.html session=session %}
   {% endunless %}{% endunless %}{% endunless %}{% endunless %}
   {% endif %}

   <!-- supported servers -->
   {% include server_support.html material=session.material %}

   <!-- session links  -->
   {% unless session.type == 'icebreaker' %}{% unless session.type == 'setup' %}{% unless session.type == 'wrapup' %}{% unless session.type == 'post-event' %}
   <h3 class="session-section">Supporting Materials </h3>
   {% include session_materials.html session=session %}
   {% endunless %}{% endunless %}{% endunless %}{% endunless %}

   <!-- end session links -->

   </div><!-- end accordion body -->
  </div><!-- end collapse -->
 </div><!-- end accordion item (training session) -->
 {% endfor %}

</div><!-- end accordion (day) -->

{% endfor %}


<br/><br/><br/>
# Acknowledgements

This Global Galaxy course is only possible thanks to a Global network of instructors and institutes.

## Presenters & Instructors & Facilitators & Community Caption Contributors

{% include hof.html %}

## Institutions

{% include institutions.html %}
