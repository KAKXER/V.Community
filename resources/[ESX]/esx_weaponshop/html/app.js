$(document).keyup(function (e) {
  if (e.key === 'Escape') {
    CloseShop();
  }
});

function CloseShop() {
  $('body').fadeOut(100);
  $('.items').empty();
  $('.container').fadeOut(100);
  $('.modal').removeClass('visible');
  $.post('http://esx_weaponshop/focusOff');
}

window.addEventListener('message', function (event) {
  var item = event.data;

  if (item.clear == true) {
    $('.items').empty();
  }

  if (item.display == true) {
    $('body').show();
    $('body').fadeIn(100);
    $('.container').show();
  }

  if (item.display == false) {
    $('body').fadeOut(100);
    $('.container').fadeOut(100);
  }

  if (item.price !== undefined) {
    $('.items').append(
      `
      <div class="item" onclick="showModal('` +
      item.item +
        `', '` +
        item.zone +
        `', '` +
        item.itemLabel +
        `', '` +
        item.desc +
        `', '` +
        item.price +
        `')">
        <img class="img-item" src="./img/` +
        item.item +
        `.png">
          <div class="label">
            <p class="itemString">` +
            item.itemLabel +
        `</p>
            <p class="itemPrice"><span class="bg-price">$` +
            item.price +
        `</span></p>
          </div>
      </div>
    `
    );
  }
});

document.addEventListener('DOMContentLoaded', function () {
  $('.container').hide();
});

function buyItem(item, zone) {
  
  $.post(
    'http://esx_weaponshop/Buyweaponshop',
    JSON.stringify({
      item: item,
      zone: zone,
    })
  );
}

function showModal(item, zone, itemLabel, desc, price) {
  $('.items').click(function () {
    $('.modal').addClass('visible');
    $('.modalimage').html(
      `<img src="./img/` +
        item +
        `.png"><div class="itemName"><p class="modal-label">` +
        itemLabel +
        `</p><span class="modal-price">$` +
        price +
        `</span></div><p class="modal-desc">` +
        desc +
        `</p>`
    );
    $('.btn-open').html(
      `<button class="btn-1" onclick="buyItem('` +
        item +
        `', '` +
        zone +
        `')"></button>`
    );
  });

  $(document).click((event) => {
    if ($(event.target).closest('.btn-1').length) {
      $('.modal').removeClass('visible');
    }
  });
}

