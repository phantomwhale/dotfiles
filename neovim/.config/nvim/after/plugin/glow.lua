local status, glow = pcall(require, "glow")
if (not status) then return end

glow.setup({
  width = 180,
  border = "rounded"
})
