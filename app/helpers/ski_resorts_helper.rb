module SkiResortsHelper
  GRADIENTS = [
    "bg-gradient-to-br from-sky-400 via-cyan-400 to-blue-600",
    "bg-gradient-to-br from-indigo-400 via-sky-400 to-cyan-500",
    "bg-gradient-to-br from-emerald-400 via-teal-400 to-cyan-500",
    "bg-gradient-to-br from-fuchsia-400 via-pink-400 to-rose-500",
    "bg-gradient-to-br from-amber-300 via-orange-400 to-rose-500",
    "bg-gradient-to-br from-violet-400 via-indigo-400 to-blue-600",
    "bg-gradient-to-br from-lime-300 via-emerald-400 to-teal-500",
    "bg-gradient-to-br from-rose-400 via-orange-400 to-amber-400"
  ].freeze

  def gradient_for_resort(resort)
    seed = resort.id || resort.name.hash
    GRADIENTS[seed % GRADIENTS.length]
  end

  def passes_count_badge(season)
    count = season.ski_passes.size
    label = count == 1 ? "1 day pass" : "#{count} day passes"
    content_tag(:span, label, class: badge_classes)
  end

  def badge_classes
    "inline-flex items-center gap-1 rounded-full bg-slate-100 text-slate-700 px-2.5 py-1 text-xs font-medium ring-1 ring-inset ring-slate-200"
  end
end
