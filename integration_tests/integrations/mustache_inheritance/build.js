var Hogan = require('hogan.js'),
    fs = require('fs'),
    path = require('path'),
    layoutSource = path.normalize(__dirname + '/vendor/mustache_inheritance_ukti_template/views/layouts/ukti_template.mustache'),
    destination = path.normalize(__dirname + '/../../html_for_testing/mustache_inheritance_integration_test_app.html'),
    govukLayout,
    compiledLayout,
    compiledTemplate,
    handleErr;

handleErr = function (err) {
  if (err) {
    throw err;
  }
};

govukLayout = fs.readFileSync(layoutSource, { encoding : 'utf-8' });
compiledLayout = Hogan.compile(govukLayout);

compiledTemplate = Hogan.compile("\
{{<layout}} \
\
  {{$htmlLang}}rb{{/htmlLang}} \
  {{$pageTitle}}This is a custom page title{{/pageTitle}} \
  {{$head}}<inserted-into-head></inserted-into-head>{{/head}} \
  {{$bodyClasses}}custom_body_class{{/bodyClasses}} \
  {{$bodyStart}}<inserted-into-body-start></inserted-into-body-start>{{/bodyStart}} \
  {{$headerClass}}custom_header_class{{/headerClass}} \
  {{$insideHeader}}<inside-header></inside-header>{{/insideHeader}} \
  {{$afterHeader}}<after-header></after-header>{{/afterHeader}} \
  {{$content}}The page content{{/content}} \
  {{$footerTop}}<footer-top></footer-top>{{/footerTop}} \
  {{$footerSupportLinks}}<footer-support-links></footer-support-links>{{/footerSupportLinks}} \
  {{$bodyEnd}}<body-end></body-end{{/bodyEnd}} \
  {{$skipLinkMessage}}Custom skip link text{{/skipLinkMessage}} \
  {{$logoLinkTitle}}Custom logo link title text{{/logoLinkTitle}} \
\
{{/layout}} \
");

fs.writeFileSync(destination, compiledTemplate.render({}, { layout: compiledLayout }), { encoding : 'utf-8' });
