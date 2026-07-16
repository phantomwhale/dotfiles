return {
  -- Helm chart templates are Go-templated YAML ({{ ... }}), not valid YAML.
  -- vim-helm's ftdetect sets filetype=helm for files under a chart's
  -- templates/ dir (it checks for a sibling Chart.yaml), which stops yamlls
  -- attaching and flagging every {{ }} directive, and gives proper
  -- Go-template + YAML syntax highlighting.
  { 'towolf/vim-helm', ft = 'helm' },
}
