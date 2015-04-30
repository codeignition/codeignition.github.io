---
layout: default
nav-name: SERVICES
group: navigation
title: Services Portfolio of The DevOps People: CodeIgnition
weight: 2
theme :
  name : bootstrap-3
---
{% include JB/setup %}

<h1>Our Services</h1>
<hr/>
<div role="tabpanel">
  <ul class="nav nav-pills" role="tablist">
    <li role="presentation" class="active col-md-3 col-md-offset-3"><a href="#devops" aria-controls="devops" role="tab" data-toggle="tab" class="col-md-12">DEVOPS</a></li>
    <li role="presentation" class="col-md-3"><a href="#webapp" aria-controls="webapp" role="tab" data-toggle="tab">WEB & MOBILE APPS</a></li>
  </ul>
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="devops">
      <div class="content-block">
        <div class="text">
          <p>As the DevOps people, we love nothing more than disrupting tradional deployments and creating fast, scalable, production-ready software & infrastructure automation for fast moving businesses.</p>
          <p>Whatever the stage of your company’s life-cycle, we can step in to manage your infrastructure or application environment so you can focus on your products and your customers.</p>
        </div>
      </div>
      <hr/>
      <div class="content-block">
        <h1 class="purple">DevOps Expertise</h1>
        <p class="text">When it comes to looking after your infrastructure & Applications environments, we kick ass at it:</p>
        <strong>
          <div class="row">
            <div class="col-md-3">CONFIGURATION</div>
            <div class="col-md-3">AUTOMATION</div>
            <div class="col-md-3">AUTO-SCALING</div>
            <div class="col-md-3">BACKUP & DISASTER RECOVERY</div>
          </div>
          <div class="row">
            <div class="col-md-3 col-md-offset-3">MONITORING & ALERTING</div>
            <div class="col-md-3">OPERATIONS & MANAGEMENT</div>
          </div>
        </strong>
      </div>
      <hr/>
      <div class="content-block">
        <h1 class="purple">DevOps Enagagement</h1>
        <p class="text">We engage with our clients in both the pre & post milestone stages. This way we can not only devise & deploy our customized solutions, but also manage and sustain the IT operations that follow.</p>
        <p class="text">But we retain the flexibility to do only dev if the operations setup is in place, or only ops if bulk of the development is done.</p>
      </div>
      <div role="tabpanel">
        <ul class="nav nav-pills" role="tablist">
          <li role="presentation" class="active col-md-3 col-md-offset-3"><a href="#managed" aria-controls="managed service" role="tab" data-toggle="tab">MANAGED SERVICES</a></li>
          <li role="presentation" class="col-md-3"><a href="#consulting" aria-controls="consulting service" role="tab" data-toggle="tab">CONSULTING SERVICES</a></li>
        </ul>
        <div class="tab-content">
          <div role="tabpanel" class="tab-pane active" id="managed">
            <div class="content-block">
              <div class="text">
                <p>Our Managed Services follow the retainer model, where we take care of your entire IT operations – lock, stock & barrel.</p>
                <p>Our managed services are split in 3 convenient plans for our clients to pick & choose from:</p>
              </div>
            </div>
            <table class="table services-table">
              <thead><tr>{% for column in site.data.services.head %}<th>{{column}}</th>{% endfor %}</tr></thead>
              <tbody>{% for row in site.data.services.body %}<tr>{% for column in row %}<td>{{column}}</td>{% endfor %}</tr>{% endfor %}</tbody>
            </table>
            <div class="content-block">
              <p class="text">Not sure which plan is best for you? <a href="/contact.html">Get in touch</a> & we will sort it out.</p>
            </div>
          </div>
          <div role="tabpanel" class="tab-pane" id="consulting">
            <div class="content-block">
              <div class="text">
                <p>We consult on an as-needed or project basis, whether they be for training, support or delivery.</p>
                <p>We can plug in anytime to identify and resolve both strategic & tactical issues that deal with Infrastructure, DevOps & Continuous Delivery.</p>
              </div>
              <p class="text">We undertake consulting projects for:</p>
              <strong>
                <div class="row text">
                  <div class="col-md-4">AUDIT & ANALYSIS</div>
                  <div class="col-md-4">DELIVERY</div>
                  <div class="col-md-4">TRAINING & WORKSHOPS</div>
                </div>
                <div class="row text">
                  <div class="col-md-5 col-md-offset-1">ONSITE & OFFSITE SUPPORT</div>
                  <div class="col-md-5">OPERATIONS & MANAGEMENT</div>
                </div>
              </strong>
              <p class="text">We charge by the hour & we try to be as cost effective as possible.</p>
              <p class="text">Not sure which model is best for you? <a href="/contact.html">Get in touch</a> & we will sort it out.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="webapp">
      <div class="content-block">
        <div class="text">
          <p>The right solution isn't always the complicated one. Sometimes all a client needs is a sweet & simple web or mobile app to do the trick.</p>
          <p>And we know how to perform such tricks all too well.</p>
        </div>
      </div>
      <hr/>
      <div class="content-block">
      <h1 class="purple">Apps Expertise</h1>
        <p class="text">We do it often, and we do it very well. We can design & develop:</p>
        <strong>
          <div class="row">
            <div class="col-md-4 col-md-offset-2">RAILS, NODE.JS & GO WEB APPS</div>
            <div class="col-md-4">ANGULAR & POLYMER WEB APPS</div>
          </div>
          <div class="row">
            <div class="col-md-4 col-md-offset-2">iOS APPLICATIONS</div>
            <div class="col-md-4">ANDROID APPLICATIONS</div>
          </div>
        </strong>
      </div>
      <hr/>
      <div class="content-block">
        <h1 class="purple">Apps Enagagement</h1>
        <p class="text">Flexibilty is key, as we engage with our clients at any stage of their product or company's life-cycle.</p>
        <p class="text">We can engage with out clients using a time & material model for evolving projects or a fixed model when the project is well defined. Or something in between, because things aren't always black & white.</p>
      </div>
    </div>
  </div>
</div>
<hr/>
<div class="content-block">
  <p class="text">
    <a href="/clients.html">Our clients</a>
    |
    <a href="/people/">Our Team</a>
  </p>
</div>
