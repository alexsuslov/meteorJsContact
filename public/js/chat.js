(function() {
  var Popup;

  jQuery.fn.popup = function(options) {
    return new Popup(options, this);
  };

  Popup = (function() {
    Popup.prototype.label = 'Popup';

    Popup.prototype.ctl = ['^', 'close X'];

    Popup.prototype.size = [320, 32, 320];

    Popup.prototype.checkStatus = false;

    Popup.prototype.status = true;

    function Popup(options, elem) {
      var _ref, _ref1, _ref2, _ref3, _ref4, _ref5;

      this.options = options;
      this.elem = elem;
      if ((_ref = this.options) != null ? _ref.position : void 0) {
        $(this.elem).addClass('popup-' + ((_ref1 = this.options) != null ? _ref1.position : void 0));
      }
      if ((_ref2 = this.options) != null ? _ref2.label : void 0) {
        this.label = this.options.label;
      }
      if ((_ref3 = this.options) != null ? _ref3.size : void 0) {
        this.size = this.options.size;
      }
      if ((_ref4 = this.options) != null ? _ref4.url : void 0) {
        this.url = this.options.url;
      }
      if ((_ref5 = this.options) != null ? _ref5.checkStatus : void 0) {
        this.checkStatus = this.options.checkStatus;
      }
      if (this.checkStatus) {
        this.checkOnLine();
      } else {
        this.displayControl();
      }
    }

    Popup.prototype.displayControl = function() {
      var _ref;

      $(this.elem).css('width', this.size[0]);
      $(this.elem).css('height', this.size[1]);
      $(this.elem).html(["<div id='control'>", "<span id='label'>" + this.label + "</span>", "<span id='ctl'>" + this.ctl[0] + "</span>", '</div>', "<div id='workspace'></div>"].join(''));
      this.elControl = $(this.elem).find('#control');
      this.elControl.css('height', this.size[1]);
      if ((_ref = this.options) != null ? _ref.background : void 0) {
        this.elControl.css('background', this.options.background);
      }
      return this.events();
    };

    Popup.prototype.hideControl = function() {
      return $(this.elem).hide();
    };

    Popup.prototype.checkOnLine = function() {
      var img, self;

      self = this;
      img = document.body.appendChild(document.createElement("img"));
      img.onload = function() {
        self.status = true;
        return self.displayControl();
      };
      img.onerror = function() {
        self.status = false;
        return $(this.elem).hide();
      };
      return img.src = self.url + "/status.gif";
    };

    Popup.prototype.display = function() {
      var self;

      self = this;
      return $(this.elem).find('#workspace').html(['<iframe width=100% height="' + this.size[2] + '" frameborder=0 src="' + this.url + '">', '</iframe>'].join(''));
    };

    Popup.prototype.clean = function() {
      return $(this.elem).find('#workspace').html('');
    };

    Popup.prototype.events = function() {
      var self;

      self = this;
      return $(this.elem).find('#control').on('click', function(e) {
        if (!self.open) {
          $(self.elem).find('#ctl').html(self.ctl[1]);
          self.display();
          return $(self.elem).animate({
            height: self.size[1] + self.size[2]
          }, 400, function() {
            return self.open = true;
          });
        } else {
          $(self.elem).find('#ctl').html(self.ctl[0]);
          return $(self.elem).animate({
            height: self.size[1]
          }, 400, function() {
            self.open = false;
            return self.clean();
          });
        }
      });
    };

    return Popup;

  })();

}).call(this);

$(function() {
  $('<div id="popup"></div>').appendTo('body');
  $('<link rel="stylesheet" href="http://42do.ru:60080/css/popup.css" type="text/css" />').appendTo('head');
  $('#popup').popup({
    url:'http://42do.ru:60080/'
    , background: '#5e87b0'
    , size:[320,32,480]
    , position:'bottom-right'
    , label:'Задать вопрос'
    });
});

