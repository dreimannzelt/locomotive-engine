Locomotive.Views.Shared ||= {}
Locomotive.Views.Shared.Fields ||= {}

class Locomotive.Views.Shared.Fields.BelongsToView extends Locomotive.Views.Shared.Fields.RelationshipView

  render: ->
    @enable_select2()
    @add_edit_link($(@el).val())

    return @

  enable_select2: ->
    options = $(@el).data()
    options.init_selection_fn = (el, callback) -> callback(id: el.val(), text: options.value)

    super($(@el), options)

    $(@el)
      .on 'select2-selecting', (el) =>
        @model.set "#{@options.name}_id", el.val

      .on 'select2-selecting', (el) =>
        @add_edit_link(el.val)

      .on 'select2-removed', (el) =>
        @remove_edit_link()

  add_edit_link: (id) -> 
    if link_template = $(@el).data("edit-link-template")
      link = link_template.replace("$ID", id)
      $(@el).parent().append(link)
      
  remove_edit_link: ->
    $(@el).next("a").remove()
