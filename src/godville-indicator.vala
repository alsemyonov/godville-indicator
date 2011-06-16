using Gtk;
using AppIndicator;
using Notify;

namespace Godville {
  public class StatusIndicator {
    private Indicator indicator;
    private Menu menu;

    private MenuItem god_item;
    private MenuItem hero_item;
    private MenuItem statistics_item;
    private MenuItem diary_item;

    private string godname;

    public StatusIndicator (string name) {
      godname = name;

      indicator = new Indicator (name, "godville", IndicatorCategory.APPLICATION_STATUS);
      indicator.set_status (IndicatorStatus.ACTIVE);
      indicator.set_attention_icon ("indicator-messages-new");

      menu = new Menu ();

      god_item = new MenuItem.with_label("Годвилль");
      god_item.activate.connect (() => {
        try {
          Process.spawn_command_line_async ("xdg-open http://godville.net/gods/%s".printf (name));
        } catch (SpawnError e) {
          error ("Cannot open god’s page: %s".printf (e.message));
        }
      });
      god_item.show ();
      menu.append (god_item);

      hero_item = new MenuItem.with_label("Данные о герое загружаются…");
      hero_item.activate.connect (() => {
        try {
          Process.spawn_command_line_async ("xdg-open http://godville.net/superhero");
        } catch (SpawnError e) {
          error ("Cannot open hero’s page: %s".printf (e.message));
        }
      });
      hero_item.show ();
      menu.append (hero_item);

      var separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      diary_item = new MenuItem();
      /*diary_item.sensitive = false;*/
      menu.append (diary_item);

      separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      statistics_item = new MenuItem();
      /*statistics_item.sensitive = false;*/
      menu.append (statistics_item);

      separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      var item = new MenuItem.with_label ("Обновить");
      item.activate.connect (() => {
        status.refresh();
      });
      item.show ();
      menu.append (item);

      separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      item = new MenuItem.with_label ("Выход");
      item.activate.connect (Gtk.main_quit);
      item.show ();
      menu.append (item);

      indicator.set_menu (menu);
    }

    public void attention() {
      indicator.set_status (IndicatorStatus.ATTENTION);
    }

    public void unattention() {
      indicator.set_status (IndicatorStatus.ACTIVE);
    }

    public void update_status(Status status) {
      var notification = new Notification (
        "%s (%i/%i)".printf (status.hero_name, status.health, status.max_health),
        status.diary_last,
        null,
        null
      );

      god_item.set_label (
        "%s\nПрана: %i%%".printf (status.godname, status.godpower)
      );

      string gender;
      if (status.gender == "male") {
        gender = "Герой";
      } else {
        gender = "Героиня";
      }

      string motto;
      if (status.motto == "") {
        motto = "\n";
      } else {
        motto = ":\n«%s»\n".printf (status.motto);
      }

      string clan;
      if (status.clan == "") {
        clan = "";
      } else {
        clan = "\nГильдия: %s (%s)".printf (status.clan, status.clan_position);
      }

      hero_item.set_label (
        "%s — %s:%sУровень %i и ещё %i%%\nХарактер: %s%s".printf (
          gender, status.hero_name,
          motto,
          status.level, status.exp_progress,
          status.alignment,
          clan
        )
      );

      string town;
      if (status.town_name == "") {
        town = "Столбов от столицы: %i шт.".printf (status.distance);
      } else {
        town = "Город: %s".printf (status.town_name);
      }

      statistics_item.set_label ("Здоровье: %i/%i\nИнвентарь: %i/%i\nЗолота: %s\nКирпичей для храма: %i\n%s\nЗадание: %s (%i%%)".printf (
        status.health, status.max_health,
        status.inventory_num, status.inventory_max_num,
        status.gold_approx,
        status.bricks_cnt,
        town,
        status.quest,
        status.quest_progress));
      statistics_item.show();

      if (status.diary_last == "") {
        diary_item.hide();
      } else {
        diary_item.set_label (status.diary_last);
        diary_item.show();
      }

      if (status.arena_fight) {
        attention();
      } else {
        unattention();
      }

      indicator.set_label ("%i".printf (status.level), "100");

      try {
        notification.show();
      } catch (Error e) {
        message ("Notification. %s: %s".printf (notification.summary, notification.body));
      }
    }
  }
}
