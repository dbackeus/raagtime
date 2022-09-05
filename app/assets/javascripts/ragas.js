/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/main/docs/suggestions.md
 */
const times = {
  "1": "06-09",
  "2": "09-12",
  "3": "12-15",
  "4": "15-18",
  "5": "18-21",
  "6": "21-24",
  "7": "24-03",
  "8": "03-06",
  "m": "Monsoon"
};

const prettyTime = time => times[time.toString()];

const filter = function(attribute, value) {
  $("tbody tr").hide();
  $(`tbody tr[data-${attribute}=${value}]`).show();

  const prettyValue = attribute === "time" ? prettyTime(value) : value;

  $(".filter").show();
  $(".filter-name").html(`${attribute} ${prettyValue}`);

  return zebra();
};

var zebra = function() {
  $("tbody tr").removeClass("odd").removeClass("even");
  $("tbody tr:visible:odd").addClass("odd");
  return $("tbody tr:visible:even").addClass("even");
};

const initialiseSuggestion = function() {
  const timeZoneOffset = (new Date().getTimezoneOffset() / 60) * -1;
  const suggestionUrl = `/ragas/suggestion?time_zone_offset=${timeZoneOffset}`;

  return $("#raga-suggestion[data-needs-load]").load(suggestionUrl);
};

const initialiseRagasTable = function() {
  const table = $("#ragas").stupidtable();

  table.bind("aftertablesort", zebra);

  $("td.time a").click(function(e) {
    e.preventDefault();
    const time = $(this).closest("tr").data("time");
    return filter("time", time);
  });

  $("td.thaat a").click(function(e) {
    e.preventDefault();
    const thaat = $(this).closest("tr").data("thaat");
    return filter("thaat", thaat);
  });

  $("#suggestion-time-filter-link").click(function(e) {
    e.preventDefault();
    filter("time", $(this).data("time"));
    return $("html, body").animate({ scrollTop: $("h2").offset().top - 20 }, 500);
  });

  $("#remove-filter-link").click(function(e) {
    e.preventDefault();
    $(".filter").hide();
    $("tbody tr").show();
    return zebra();
  });

  return $("th.title").click();
};

$(function() {
  initialiseSuggestion();
  return initialiseRagasTable();
});

