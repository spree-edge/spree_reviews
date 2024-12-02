Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.add_to_section(
      'products',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'reviews',
        ::Spree::Core::Engine.routes.url_helpers.admin_reviews_path
      )
      .with_manage_ability_check(::Spree::Review)
      .with_match_path('/reviews')
      .build
    )

    Rails.application.config.spree_backend.main_menu.add_to_section(
      'settings',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'review_settings',
        ::Spree::Core::Engine.routes.url_helpers.edit_admin_review_settings_path
      )
      .with_manage_ability_check(::Spree::ReviewSetting)
      .with_match_path('/review_settings')
      .build
    )
  end
end
