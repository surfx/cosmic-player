use cosmic::app::Action as AppAction;
use cosmic::Action;
fn nav_bar(&self) -> Option<Element<'_, Action<Self::Message>>> {
    if !self.core().nav_bar_active() {
        return None;
    }

    let nav_model = self.nav_model()?;

    let mut nav =
        cosmic::widget::nav_bar(nav_model, |id| Action::Cosmic(AppAction::NavBar(id)))
            .on_context(|id| Action::Cosmic(AppAction::NavBarContext(id)))
            .into_container()
            .width(Length::Shrink)
            .height(Length::Fill);

    if !self.core().is_condensed() {
        nav = nav.max_width(280);
    }

    let search_input = widget::text_input("Filter...", &self.search)
        .id(cosmic::widget::Id::new("search_input"))
        .on_input(|s| Action::App(Message::SearchChanged(s)))
        .width(Length::Fill);

    let search_container = widget::container(search_input)
        .padding(8);

    let column = widget::column::with_capacity(2)
        .push(search_container)
        .push(nav);

    Some(Element::from(column))
}
