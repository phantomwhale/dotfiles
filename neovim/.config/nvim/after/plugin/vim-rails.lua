-- Experimental option, allows creation of a related spec file (via projections) when one not found
vim.api.nvim_set_option_value("confirm", true, {})

-- provide more comprehensive mappings for controller to request specs
vim.g.rails_projections = {
  ["app/controllers/*_controller.rb"] = {
    ["alternate"] = {
      "spec/requests/{}_spec.rb",
      "spec/requests/{}_request_spec.rb",
      "spec/requests/{}_controller_spec.rb",
      "spec/api/{}_spec.rb",
      "spec/controllers/{}_controller_spec.rb",
    }
  },
  ["spec/requests/*_spec.rb"] = {
    ["alternate"] = {
      "app/controllers/{}.rb",
      "app/controllers/{}_controller.rb"
    }
  },
  ["spec/requests/*_request_spec.rb"] = {
    ["alternate"] = {
      "app/controllers/{}_controller.rb"
    }
  },
  ["spec/requests/*_controller_spec.rb"] = {
    ["alternate"] = {
      "app/controllers/{}_controller.rb"
    }
  },
  ["spec/api/*_spec.rb"] = {
    ["alternate"] = {
      "app/controllers/{}.rb",
      "app/controllers/{}_controller.rb"
    }
  },
  ["spec/routing/*_routing_spec.rb"] = {
    ["alternate"] = {
      "app/controllers/{}_controller.rb"
    }
  },
  ["spec/routing/*_spec.rb"] = {
    ["alternate"] = {
      "app/controllers/{}.rb",
      "app/controllers/{}_controller.rb"
    }
  }
}
