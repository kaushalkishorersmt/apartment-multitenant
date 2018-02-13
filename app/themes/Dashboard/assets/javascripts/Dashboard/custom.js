jQuery(function() {

    var product_segments;
    if ($('#product_product_segment_id').val() == '') {
        $('#product_product_segment_id').hide();
    }
    product_segments = $('#product_product_segment_id').html();
    return $('#product_main_product_id').change(function() {
        var main_product, escaped_main_product, options;
        main_product = $('#product_main_product_id :selected').val();
        escaped_main_product = main_product.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        options = $(product_segments).filter("optgroup[label='" + escaped_main_product + "']").html();
        if (options) {
            $('#product_product_segment_id').html("<option value=''>Select Sub Category</option><option value=''></option>" + options);
            return $('#product_product_segment_id').show();
        } else {
            $('#product_product_segment_id').empty();
            return $('#product_product_segment_id').hide();
        }
    });

});

jQuery(function() {

    var categories;
    if ($('#product_category_id').val() == '') {
        $('#product_category_id').hide();
    }
    categories = $('#product_category_id').html();
    return $('#product_product_segment_id').change(function() {
        var product_segments, escaped_product_segment, options;
        product_segments = $('#product_product_segment_id :selected').val();
        escaped_product_segment = product_segments.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        options = $(categories).filter("optgroup[label='" + escaped_product_segment + "']").html();
        if (options) {
            $('#product_category_id').html("<option value=''>Select Product SKU</option><option value=''></option>" + options);
            return $('#product_category_id').show();
        } else {
            $('#product_category_id').empty();
            return $('#product_category_id').hide();
        }
    });
});

jQuery(function() {

    var subcategories;
    if ($('#product_subcategory_id').val() == '') {
        $('#product_subcategory_id').hide();
    }
    subcategories = $('#product_subcategory_id').html();
    return $('#product_category_id').change(function() {
        var product_category, escaped_product_category, options;
        product_category = $('#product_category_id :selected').val();
        escaped_product_category = product_category.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
        options = $(subcategories).filter("optgroup[label='" + escaped_product_category + "']").html();
        if (options) {
            $('#product_subcategory_id').html("<option value=''>Select Product Type</option><option value=''></option>" + options);
            return $('#product_subcategory_id').show();
        } else {
            $('#product_subcategory_id').empty();
            return $('#product_subcategory_id').hide();
        }
    });
});

$(document).on('click', 'form .remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').remove();
    get_quantity_sum();
    return event.preventDefault();
});

$(document).on('click', 'form .add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
});
$(document).ready(function() {
    get_quantity_sum();
});

$(document).on("change", ".quantity", function() {
    get_quantity_sum();
});

function get_quantity_sum() {
    var sum = 1;
    $(".quantity").each(function() {
        sum += Number($(this).val());
    });
    //console.log(sum);
    if (sum < 1) {
      sum = 1;
    }
    $("#totalqty").text("Total Quantity: " + sum)
    $("#product_quantity").val(sum)
}



// check if domain name entered in alredy have domain is correct format
$(document).on("change", "#shop_domain_name", function() {
    var domainPattern = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$/;
    var domainrequested = $("#shop_domain_name").val();
    if (domainrequested.match(domainPattern)) {

    } else {
        alert("Please provide valid domain, like YourAwesomeWebsite.in or YourAwesomeWebsite.co.in");
    }
});

//domain section - already have domain show
function switchVisible() {
    if (document.getElementById('new_domain')) {

        if (document.getElementById('new_domain').style.display == 'none') {
            document.getElementById('new_domain').style.display = 'block';
            document.getElementById('existing_domain').style.display = 'none';
        } else {
            document.getElementById('new_domain').style.display = 'none';
            document.getElementById('existing_domain').style.display = 'block';
        }
    }
}

// check availablitity section - check if domain entered is correct format
$(document).on("change", "#domain_available", function() {
    var domainPattern = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$/;
    var domainrequested = $("#domain_available").val();
    
    if (domainrequested.match(domainPattern)) {

    } else {
        alert("Please provide valid domain, like YourAwesomeWebsite.in or YourAwesomeWebsite.co.in");
    }
});

// check availability of domain entered in check availablitity section
$(document).on('click', '#check_domain_btn', function(event) {
    var domainrequested = $("#domain_available").val();
    window.location = '?d=' + domainrequested;
});

// old code for selecting available domain
// function select_domain_btn(ref) {
//     var href = this.href;
//
//     // Don't follow the link
//     event.preventDefault();
//
//     // Do the async thing
//     startSomeAsyncThing(function() {
//         if (window.location.href.indexOf("d=") < 0){
//             window.location = document.location.origin + ref + '?d=' + $("#my_domain_name").val() + '&state=exist';
//         }
//         else{
//             window.location = ref;
//         }
//     });
// }
